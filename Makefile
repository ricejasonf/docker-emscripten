image_emscripten:
	docker build --force-rm=true -f Dockerfile-emscripten -t ricejasonf/emscripten:1.37.36 .

image_fastcomp:
	docker build --force-rm=true -f Dockerfile-fastcomp -t ricejasonf/emscripten_fastcomp:1.37.36 .

run:
	docker run --rm -it ricejasonf/emscripten
