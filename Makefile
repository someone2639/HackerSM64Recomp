default: all

all: build/HackerSM64Recompiled

N64RECOMP := N64Recomp/build/N64Recomp
RSPRECOMP := N64Recomp/build/RSPRecomp

ROM := sm64.z64
ELF := sm64.elf

build/version.h: $(ROM)
	python tools/makeVersion.py $< > $@

RecompiledFuncs/: $(ELF)
	cmake -S N64Recomp -B N64Recomp/build
	$(MAKE) -C N64Recomp/build
	$(N64RECOMP) sm64.toml
	$(RSPRECOMP) aspMain.toml
	CC=clang CXX=clang++ cmake -B build -S .

build/HackerSM64Recompiled: RecompiledFuncs/ build/version.h
	$(MAKE) -C build


clean:
	rm -r -f build
reset:
	rm -r -f ~/.config/HackerSM64Recompiled


