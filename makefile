ZASM := "zasm"
PYTHON := "python"
DDE := ./dungeon-delver-engine
DDE_TOOLS := $(DDE)/tools

SRC_DIR := ./src
APP_SRC_DIR := $(SRC_DIR)/acts
BUILD_DIR := ./build

COMMON_TEXT_JSON := $(SRC_DIR)/common/text.json
ACT_1_TEXT_JSON := $(SRC_DIR)/acts/bg31/text.json
COMPRESSED_TEXT := $(BUILD_DIR)/generated/bg31/compressed_text.asm

APPS := $(wildcard $(SRC_DIR)/acts/*)
APP_NAMES := $(foreach app,$(APPS),$(subst $(APP_SRC_DIR)/,, $(app)))
APP_OUTPUT_FILES := $(foreach app, $(APP_NAMES), $(BUILD_DIR)/$(app).hex $(BUILD_DIR)/$(app).co)

# credit to https://stackoverflow.com/a/12959764
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

ALL_SRC_ASM := $(call rwildcard,$(SRC_DIR)/,*.asm)
ALL_DDE_ASM := $(call rwildcard,$(DDE)/,*.asm)

.PRECIOUS: $(BUILD_DIR)/%.hex $(BUILD_DIR)/%.co

all: $(APP_OUTPUT_FILES)

$(COMPRESSED_TEXT): $(ACT_1_TEXT_JSON) $(COMMON_TEXT_JSON)
	@mkdir -p $(BUILD_DIR)/generated/bg31
	$(PYTHON) $(DDE_TOOLS)/compressor -i $(ACT_1_TEXT_JSON) $(COMMON_TEXT_JSON) -o $(COMPRESSED_TEXT)

$(BUILD_DIR)/%.hex: $(COMPRESSED_TEXT) $(ALL_SRC_ASM) $(ALL_DDE_ASM)
	@mkdir -p $(BUILD_DIR)
	$(ZASM) --8080 -x $(patsubst %.hex,%/main.asm,$(subst build,src/acts,$@)) -o $@

$(BUILD_DIR)/%.co: $(COMPRESSED_TEXT) $(ALL_SRC_ASM) $(ALL_DDE_ASM)
	@mkdir -p $(BUILD_DIR)
	$(ZASM) --8080 $(patsubst %.co,%/main.asm,$(subst build,src/acts,$@)) -o $@.obj
	@perl -e ' print pack "S<", 45568 ' > $@.hdr
	@perl -e ' print pack "S<", -s "$@.obj" ' >> $@.hdr
	@perl -e ' print pack "S<", 45568 ' >> $@.hdr
	@cat $@.hdr $@.obj > $@

clean:
	@rm -rfv $(BUILD_DIR)
