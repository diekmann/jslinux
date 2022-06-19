
# Assumes rootless docker

temu: $(shell find temu -type f)
	# looks like this was originally compiled emscripten older than 1.38.27, since this version removes Pointer_stringify, which was used in the js/lib.js.
	# only emscripten starting at 1.39.0 is found on dockerhub, I could not find older images.
	# I made it compile and start with 2.0.34. There are no integration tests, so no idea if this is stable.
	docker run --rm -it -v /home/corny/git/jslinux/temu/tinyemu-2019-12-21:/temu --workdir /temu emscripten/emsdk:3.1.13 make --makefile=Makefile.js

public:
	mkdir -p ./public

# separate build target, because they may be huge
copy-vmimages: public
	cp -ar vmimages ./public

gh-pages: temu $(shell find jslinux -type f) public copy-vmimages
	cp jslinux/jslinux-2019-12-21/index.html ./public
	cp jslinux/jslinux-2019-12-21/jslinux.js ./public
	cp jslinux/jslinux-2019-12-21/term.js ./public
	cp jslinux/jslinux-2019-12-21/style.css ./public
	cp -r jslinux/jslinux-2019-12-21/images ./public
	cp jslinux/jslinux-2019-12-21/root-riscv64.cfg ./public
	cp jslinux/jslinux-2019-12-21/bbl64.bin ./public
	cp jslinux/jslinux-2019-12-21/kernel-riscv64.bin ./public
	cp -r jslinux/jslinux-2019-12-21/root-riscv64 ./public
	
	cp temu/tinyemu-2019-12-21/js/riscvemu* ./public
	cp temu/tinyemu-2019-12-21/js/x86emu* ./public

clean:
	make -C temu/tinyemu-2019-12-21 clean
	rm -rf temu/tinyemu-2019-12-21/js/riscvemu*
	rm -rf ./public
