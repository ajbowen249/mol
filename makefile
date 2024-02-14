ZASM := "zasm"

SRC_DIR := ./src
APP_SRC_DIR := $(SRC_DIR)/acts
BUILD_DIR := ./build

APPS := $(wildcard $(SRC_DIR)/acts/*)
APP_NAMES := $(foreach app,$(APPS),$(subst $(APP_SRC_DIR)/,, $(app)))
APP_OUTPUT_FILES := $(foreach app, $(APP_NAMES), $(BUILD_DIR)/$(app).hex)

.PRECIOUS: $(BUILD_DIR)/%.hex

all: $(APP_OUTPUT_FILES)

$(BUILD_DIR)/%.hex: $(SRC_DIR)/**/*.asm $(SRC_DIR)/**/**/*.asm $(SRC_DIR)/**/**/**/*.asm
	@mkdir -p $(BUILD_DIR)
	$(ZASM) --8080 -x $(patsubst %.hex,%/main.asm,$(subst build,src/acts,$@)) -o $@

clean:
	@rm -rfv $(BUILD_DIR)
