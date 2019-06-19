sprites=$(wildcard sprite/*.aseprite)
jsons=$(addprefix ./build/, $(notdir $(sprites:.aseprite=.json)))
atlas=./atlas.png
index=./index.json
merge=./atlas.json
aseprite=~/.steam/steam/steamapps/common/Aseprite/aseprite
texatlas_script=texatlas.py
merge_script=merge_aseprite_json.py

all: create_build_dirs $(atlas) $(merge)

debug:
	@echo $(merge)

$(merge): $(index) $(atlas)
	@python $(merge_script) $^ $@

$(atlas): $(jsons)
	@python $(texatlas_script) $^ -i $(index) -s $(atlas)

build/%.json: sprite/%.aseprite
	@$(aseprite) -b $< --sheet $(@:.json=.png) --data $@ \
	           --list-slices  --trim --inner-padding 1 --format json-array\
	           --list-tags

create_build_dirs:
	@mkdir -p build

clean:
	@rm -rf build
	@rm -f $(info)
	@rm -f $(atlas)
