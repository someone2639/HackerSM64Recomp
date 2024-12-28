default: all

all: build/HackerSM64Recompiled

N64RECOMP := N64Recomp/build/N64Recomp
RSPRECOMP := N64Recomp/build/RSPRecomp

build/us_n64/sm64.z64:
	$(MAKE) -C HackerSM64 BUILD_DIR=../build/us_n64 RECOMP=1
	python tools/makeVersion.py $@ > build/version.h

RecompiledFuncs/: build/us_n64/sm64.z64
	cmake -S N64Recomp -B N64Recomp/build
	$(MAKE) -C N64Recomp/build
	$(N64RECOMP) sm64.toml
	$(RSPRECOMP) aspMain.toml
	CC=clang CXX=clang++ cmake -B build -S .

build/HackerSM64Recompiled: RecompiledFuncs/
	$(MAKE) -C build


clean:
	rm -r -f build
reset:
	rm -r -f ~/.config/HackerSM64Recompiled


