all: generate

generate:
	raco pollen render -s .

server:
	raco pollen start . 5555

reset:
	raco pollen reset

clean: reset
	rm *.html
	rm *.css
	rm -r cv/*.html
	rm -r cv/*.css
	rm -r cv/*.ltx
	rm -r cv/*.pdf
	rm -r posts/*.html
	rm -r secret/*.html
	rm -r secret/*.css
	rm -r drafts/*.html
