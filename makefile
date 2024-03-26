ZASM := "zasm"
PYTHON := "python"
DDE_TOOLS := ./dungeon-delver-engine/tools

SRC_DIR := ./src
APP_SRC_DIR := $(SRC_DIR)/acts
BUILD_DIR := ./build

COMMON_TEXT_JSON := $(SRC_DIR)/common/text.json
ACT_1_TEXT_JSON := $(SRC_DIR)/acts/bg31/text.json
COMPRESSED_TEXT := $(BUILD_DIR)/generated/bg31/compressed_text.asm

APPS := $(wildcard $(SRC_DIR)/acts/*)
APP_NAMES := $(foreach app,$(APPS),$(subst $(APP_SRC_DIR)/,, $(app)))
APP_OUTPUT_FILES := $(foreach app, $(APP_NAMES), $(BUILD_DIR)/$(app).hex)

.PRECIOUS: $(BUILD_DIR)/%.hex

all: $(APP_OUTPUT_FILES)

$(COMPRESSED_TEXT): $(ACT_1_TEXT_JSON) $(COMMON_TEXT_JSON)
	@mkdir -p $(BUILD_DIR)/generated/bg31
	$(PYTHON) $(DDE_TOOLS)/compressor -i $(ACT_1_TEXT_JSON) $(COMMON_TEXT_JSON) -o $(COMPRESSED_TEXT)

$(BUILD_DIR)/%.hex: $(COMPRESSED_TEXT) $(SRC_DIR)/**/*.asm $(SRC_DIR)/**/**/*.asm $(SRC_DIR)/**/**/**/*.asm
	@mkdir -p $(BUILD_DIR)
	$(ZASM) --8080 -x $(patsubst %.hex,%/main.asm,$(subst build,src/acts,$@)) -o $@

clean:
	@rm -rfv $(BUILD_DIR)
