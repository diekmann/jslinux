
all:
	# Assumes rootless docker
	
	# emscripten 1.38.27 removes Pointer_stringify (use UTF8ToString instead)
	# only emscripten starting at 1.39.0 is found on dockerhub, I could not find older images.
	# also compiles with 1.40.1
	# does compile with 3.1.13 or 2.0.34 but VM does not start
	# there is the reason why it like no longer compiles: https://github.com/emscripten-core/emscripten/commit/e76237b6eef44ecf6e1d8aeb656e8e781251ac21
	docker run --rm -it -v /home/corny/git/jslinux/temu/tinyemu-2019-12-21:/temu --workdir /temu emscripten/emsdk:1.40.1 make --makefile=Makefile.js
	cp temu/tinyemu-2019-12-21/js/riscvemu* jslinux/jslinux-2019-12-21/

clean:
	make -C temu/tinyemu-2019-12-21 clean
	rm -rf temu/tinyemu-2019-12-21/js/riscvemu*
