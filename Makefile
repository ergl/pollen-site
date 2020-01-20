all: generate

generate:
	raco pollen render -s .
	raco pollen render -t pdf cv/index.poly.pm

server:
	raco pollen start . 5555

reset:
	raco pollen reset

clean: reset
	rm -f CNAME
	rm -f atom.xml
	rm -f *.html
	rm -f *.css
	rm -rf cv/*.html
	rm -rf cv/*.css
	rm -rf cv/*.ltx
	rm -rf cv/*.pdf
	rm -rf posts/*.html
	rm -rf secret/*.html
	rm -rf secret/*.css
	rm -rf drafts/*.html
