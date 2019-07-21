aseprite_bin=lib/aseprite/build/bin/aseprite

all: $(aseprite_bin) export_art

export_art: $(aseprite_bin)
	make -C assets/ all

$(aseprite_bin):
	mkdir -p lib/aseprite/build
	cd lib/aseprite; git submodule update --init --recursive
	cd lib/aseprite/build; cmake ..; make -j3
