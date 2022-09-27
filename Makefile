all: generate

generate:
	raco pollen render -s .

server:
	raco pollen start . 5555

reset:
	raco pollen reset

clean: reset
	rm -f CNAME
	rm -f atom.xml
	rm -f *.html
	rm -f *.css
	rm -rf posts/*.html
	rm -rf secret/*.html
	rm -rf secret/*.css
	rm -rf drafts/*.html
