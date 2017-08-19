image:
	docker build --force-rm=true -t ricejasonf/emscripten:1.37.19 .

image_fastcomp:
	docker build --force-rm=true -f Dockerfile-fastcomp -t ricejasonf/emscripten_fastcomp:1.37.19 .

run:
	docker run --rm -it ricejasonf/emscripten
