VERSION = 0.3
NAME = VTSPS2-TESTMODE
EE_BIN = $(NAME).ELF
EE_BIN_PACKED = $(NAME)-packed.ELF
EE_BIN_STRIPPED = $(NAME)-stripped.ELF
EE_OBJS = $(NAME).o
EE_LIBS = -lc -ldebug

all:
	@echo "======================================="
	@echo "=== Building $(NAME) v$(VERSION)    ==="
	@echo "======================================="
	$(MAKE) $(EE_BIN_PACKED)

clean:
	@echo "================"
	@echo "=== Cleaning ==="
	@echo "================"
	rm -fr *.ELF *.o *.bak

run: $(EE_BIN)
	ps2client execee host:$(EE_BIN)

reset:
	ps2client reset

$(EE_BIN_STRIPPED): $(EE_BIN)
	@echo "================="
	@echo "=== Stripping ==="
	@echo "================="
	$(EE_STRIP) -o $@ $<
	
$(EE_BIN_PACKED): $(EE_BIN_STRIPPED)
	@echo "==================="
	@echo "=== Compressing ==="
	@echo "==================="
	~/ps2homebrew/ps2-packer/ps2-packer -v $< $@
	
include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.eeglobal