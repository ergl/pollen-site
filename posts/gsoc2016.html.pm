#lang pollen

◊(define-meta title "Lasp and the Google Summer of Code")
◊(define-meta published "2016-08-16")
◊(define-meta description "My experiences during Google Summer of Code on the Lasp project.")

◊hr{}

◊strong{Update}

If you want to read a more formal explanation, we wrote a paper about our optimization. Grab a copy from ◊l["http://arxiv.org/abs/1609.01068"]{arxiv}.

Also, I'll be speaking at ◊l["http://2016.splashcon.org/track/agere2016"]{AGERE!} later this year, colocated with ◊l["http://2016.splashcon.org/home"]{SPLASH 2016}. If you're attending, please feel free to drop by and say hi!

◊hr{}

Over the past few months, I've been working in ◊l["http://lasp-lang.org"]{Lasp} as part of the 2016 ◊l["https://developers.google.com/open-source/gsoc/"]{Google Summer of Code}. Here I want to share some of my experiences, as well as give an overview of what I worked on during that time.

Lasp is a new programming model designed to simplify large scale, fault-tolerant, distributed programming. Lasp programs follow a dataflow, functional approach. The runtime seamlessly adapts to a dynamic network topology and replicates your data to different nodes.

My work was mostly focused on run-time optimizations. In particular, on applying deforestation techniques in order to remove intermediate values from computations.

I spent most of my time adding ways to monitor programs as they execute (we even added a control flow visualization tool, that would let you see how different functions and values interacted). I also had to modify some internal libraries that we depended on to support our optimizations.

◊blockquote{
The list with all the changes I made to the main repository is ◊l["https://github.com/lasp-lang/lasp/commits/unstable?author=ergl"]{here}, the list of changes to the supporting library, ◊code{gen_flow}, can be found ◊l["https://github.com/lasp-lang/gen_flow/commits/master?author=ergl"]{here}.
}

◊h4{Some Background}

What do I mean by intermediate values? And what is deforestation? (◊ref['theory]{skip ahead} if you are already familiar with these terms.) Imagine the following piece of code:

◊codeblock['txt]{
> sum (map inc [1..10])
65
}

Here, we increment all values in a list, and then compute the sum of all the elements. We could imagine the above to execute as follows:

◊codeblock['txt]{
sum (map inc [1..10])
     ---------------
       |
       V
sum [2..11]
}

We can already see a problem. We don't care about ◊code{[2..11]}, we just want the sum of that list. We call this an intermediate value. In general, every time you compose functions together, you have an implicit intermediate value that holds the result of one function, and serves as an argument to the next one.

In a small program like this one, we might not care about it, but for large programs, or for intermediate values that might allocate a lot of memory, we will want to remove them. In the previous example, we could remove the intermediate list by rewriting our program like this:

◊codeblock['ocaml]{
> let h 0 m n =
    if m > n then a
    else h (a + inc m) (m + 1) n
  in
  h 0 1 10
65
}

Okay, so this isn't nice to look at. Maybe better names would help, but this is already harder to read and understand than our original one-liner. In addition, we have lost the ability to reuse the original ◊code{sum} and ◊code{map} functions.

We could let the compiler take care of it. In fact, the Glasgow Haskell Compiler ◊l["http://research.microsoft.com/en-us/um/people/simonpj/Papers/rules.htm"]{already does}, but you can also implement it with ◊l["https://hackage.haskell.org/package/stream-fusion"]{certain libraries}. Programs without intermediate values are called ◊em{treeless} programs, hence the name deforestation; the process of transforming programs into ◊em{treeless} ones.

◊label['theory]{◊h4{Graphs, Lasp and shortcuts}}

Intermediate values in Lasp not only waste memory, they also waste network bandwidth, increase latency and degrade run-time performance. This means that the incentive for removing these values is even greater.

When I first joined, I had several vague ideas about how to tackle the project. ◊l["http://dl.acm.org/citation.cfm?id=80104"]{I looked} ◊l["http://dl.acm.org/citation.cfm?id=165214"]{through} ◊l["http://dl.acm.org/citation.cfm?id=224221"]{a lot} ◊l["http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.28.6971"]{of papers} ◊l["http://link.springer.com/chapter/10.1007%2F978-1-4471-3215-8_14"]{about} ◊l["http://dl.acm.org/citation.cfm?id=1291199"]{deforestation}. After some thinking, and a fruitful meeting with one of my mentors, we arrived at a promising solution, combining graph theory and control flow analysis.

Here's a simple Lasp program (currently implemented in Erlang):

◊codeblock['erlang]{
{ok, {S1, _, _, _}} = lasp:declare(orset),
{ok, {S2, _, _, _}} = lasp:declare(orset),
{ok, {S3, _, _, _}} = lasp:declare(orset),

lasp:map(S1, fun(X) ->
  X + 1
end, S2),

lasp:filter(S2, fun(X) ->
  X rem 2 =:= 0
end, S3).
}

This creates a dataflow computation that reads values from ◊code{S1}, increments the contents and writes them to ◊code{S2}. Then, it keeps the even values, and writes those to ◊code{S3}. Here, our intermediate value is ◊code{S2}. We can also visualize the previous program as a graph:

◊codeblock['txt]{
S1 -> (map inc) -> S2 -> (filter even) -> S3
}

In fact, we can represent all Lasp programs as directed acyclic graphs. When they represent the ◊em{dependencies} between the values, we call them acyclic dependency graphs.

In our previous example, we could easily spot ◊code{S2} as our intermediate value. However, for larger programs, we might want to find a way to automatically find these values.

If we modify our previous graph, and encode the functions as edges in the graph, we arrive at the following representation:

◊codeblock['txt]{
   map inc   filter even
      |           |
      V           V
S1 ------> S2 ----------> S3
}

Now we can start to form an intuition about what intermediate values look like: any value, which, when represented as a vertex in our dependency graph, only has one parent and one child.

We can extend this definition to paths of arbitrary length. In ◊code{S1 -> S2 -> ... -> SN-1 -> SN}, the intermediate values are ◊code{[S2 .. SN-1]}.

Alright, so now we have a way to identify intermediate values in our program. The next step is to remove them. Going back to our first Lasp example:

◊codeblock['txt]{
   map inc   filter even
      |           |
      V           V
S1 ------> S2 ----------> S3
}

We can sidestep ◊code{S2} completely by connecting ◊code{S1} to ◊code{S3}:

◊codeblock['txt]{
   map inc   filter even
      |           |
      V           V
S1 ------> S2 ----------> S3
 |                        ^
 |________________________|
            ^
            |
  (map inc) ∘ (filter even)
}

Given that we have composed the old functions into a new one, we can remove ◊code{S2} from the graph, as well as the intermediate edges:

◊codeblock['txt]{
 (map inc) ∘ (filter even)
           |
           V
S1 -----------------> S3
}

This is what we call ◊em{edge composition}. More generally, it involves a process called ◊em{edge contraction}, which has been used before to, for example, ◊l["http://algo2.iti.kit.edu/download/contract.pdf"]{speed up route planning in road networks}.

Now you might read the above and ask yourself, "Aren't the intermediate values ◊em{still} there, implicit in the composition of the old functions?"

And you'd be right, as the Erlang VM doesn't apply deforestation to programs◊note{There has been some work done in this area, mainly by ◊l["https://users.ece.cmu.edu/~aavgerin/papers/Erlang09.pdf"]{Avgerinos, Sagonas} and ◊l["http://studentarbeten.chalmers.se/publication/179780-supercompiling-erlang"]{Weinholt}.}. However, the cost of these values, in Erlang, compared to to the cost of intermediate values, in Lasp, is really small.

◊h4{What about the network?}

We're still not done, however. Remember, Lasp runs the same program concurrently on different machines. When you're dealing with the network, you have to assume that some machines will get disconnected.

What would happen if we applied our optimization in a disconnected node, and discovered a new function writing to ◊code{S2} when we rejoined the network?

◊codeblock['txt]{
        (map inc) ∘ (filter even)
                  |
                  V
(Node 1):  S1 ------------> S3
                  S2
                   ^
(Node 2):  S4 _____|
                ^
                |
            map square
}

When this happens, we undo our optimization (via a process called ◊em{vertex cleaving}) at the disconnected node:

◊codeblock['txt]{
   map inc
      |
      V
S1 ------   filter even
        |      |
        V      V
        S2 ------> S3
        ^
        |
S4 ------
     ^
     |
  map square
}

We are able to do this since we stored the original functions ◊code{map inc} and ◊code{filter even} when we removed ◊code{S2}.

Can this lead to inconsistencies? What if ◊code{S4} read from ◊code{S2}, instead of writing to it? Wouldn't it read old data? Lasp sidesteps this issue by implementing all its variables with special data types called Conflict-Free Replicated Data Types, or CRDTs◊note{Christopher Meiklejohn has collected a great list of ◊l["https://christophermeiklejohn.com/crdt/2014/07/22/readings-in-crdts.html"]{links and information about CRDTs}.}, for short. One of the many properties these data types guarantee is that, no matter the order of updates on a particular instance, the final state will always be the same.

◊h4{Results and Future Work}

After implementing the optimizations described above (we called ◊em{dynamic path contraction} to the combination of ◊em{edge contraction} and ◊em{vertex cleaving}), we ran several benchmarks on different application topologies. For each application, we identified the longest path in its graph representation, and measured the time it took for an update on one endpoint to reach the other. Depending on the topology, we found a 25% to 75% decrease on end-to-end distribution latency.

While the results are very promising, there are still some things that could improve them even more. In particular, there are certain types of intermediate values that the current implementation isn't able to remove, mainly those that involve binary functions. There are also some operations that aren't currently monitored, like ◊em{stream}, that introduce non-determinism into the system.

With that said, I look forward to keep working on these issues and be able to improve Lasp.

All in all, it's been an amazing experience. I've received a lot of support from my mentors and teammates; the Lasp team is full of incredible people. Thank you.