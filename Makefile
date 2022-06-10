
all:
	# Assumes rootless docker
	docker run --rm -it -v /home/corny/git/jslinux/temu/tinyemu-2019-12-21:/temu --workdir /temu emscripten/emsdk:3.1.13 make --makefile=Makefile.js
	cp -i temu/tinyemu-2019-12-21/js/riscvemu* jslinux/jslinux-2019-12-21/

clean:
	make -C temu/tinyemu-2019-12-21 clean
	rm -rf temu/tinyemu-2019-12-21/js/riscvemu*
