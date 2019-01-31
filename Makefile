.PHONY=image_emscripten image_fastcomp run push

image_fastcomp:
	docker build --force-rm=true -f Dockerfile-fastcomp -t ricejasonf/emscripten_fastcomp:1.38.25 .

image_emscripten: image_fastcomp
	docker build --force-rm=true -f Dockerfile-emscripten -t ricejasonf/emscripten:1.38.25 .

run:
	docker run --rm -it ricejasonf/emscripten

push: image_fastcomp image_emscripten
	docker push ricejasonf/emscripten_fastcomp:1.38.25 && \
	docker push ricejasonf/emscripten:1.38.25
