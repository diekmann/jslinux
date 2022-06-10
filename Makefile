
all:
	# Assumes rootless docker
	
	# emscripten 1.38.27 removes Pointer_stringify (use UTF8ToString instead)
	# only emscripten starting at 1.39.0 is found on dockerhub, I could not find older images.
	docker run --rm -it -v /home/corny/git/jslinux/temu/tinyemu-2019-12-21:/temu --workdir /temu emscripten/emsdk:1.39.0 make --makefile=Makefile.js
	cp -i temu/tinyemu-2019-12-21/js/riscvemu* jslinux/jslinux-2019-12-21/

clean:
	make -C temu/tinyemu-2019-12-21 clean
	rm -rf temu/tinyemu-2019-12-21/js/riscvemu*
