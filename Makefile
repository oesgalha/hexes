CC=gcc

HEXES_ROOT=$(shell pwd)
TERM_COLS=$(shell tput cols)
TERM_SEPARATOR=$(shell printf '=%.0s' {1..$(TERM_COLS)})

all: hexesbin

hexesbin: build_mruby
	@echo "\033[94m$(TERM_SEPARATOR)"
	@echo "Building hexes"
	@echo "$(TERM_SEPARATOR)"

	$(eval include $(MRUBY_ROOT)/build/host/lib/libmruby.flags.mak)
	$(eval LIBS = $(MRUBY_LIBS) $(MRUBY_LDFLAGS_BEFORE_LIBS) $(MRUBY_ROOT)/build/host/lib/libmruby.a )
	$(CC) $(MRUBY_CFLAGS) $(HEXES_ROOT)/tools/hexes/hexes.c $(MRUBY_LDFLAGS) $(LIBS) -o $(HEXES_ROOT)/bin/hexes

	@echo "\033[0m\033[92m$(TERM_SEPARATOR)"
	@echo "Hexes built with success! The executable is located at: $(HEXES_ROOT)/bin/hexes"
	@echo "Happy hacking :)"
	@echo "$(TERM_SEPARATOR)\033[0m"

build_mruby: downloaded_mruby

	@echo "\033[94m$(TERM_SEPARATOR)"
	@echo "Building mruby"
	@echo "$(TERM_SEPARATOR)"

	cp $(HEXES_ROOT)/build_config.rb $(MRUBY_ROOT)/build_config.rb && cd $(MRUBY_ROOT) && $(MAKE) && git checkout build_config.rb

	@echo "\033[0m\033[92m$(TERM_SEPARATOR)"
	@echo "Mruby built with success!"
	@echo "$(TERM_SEPARATOR)\033[0m"

downloaded_mruby:
ifeq ($(wildcard $(HEXES_ROOT)/mruby),)
	@echo "\033[94m$(TERM_SEPARATOR)"
	@echo "Mruby not found. Downloading mruby..."
	@echo "$(TERM_SEPARATOR)"

	cd $(HEXES_ROOT)
	git clone --depth=1 --branch 1.1.0 https://github.com/mruby/mruby.git

	@echo "\033[0m\033[92m$(TERM_SEPARATOR)"
	@echo "Mruby downloaded! Moving on..."
	@echo "$(TERM_SEPARATOR)\033[0m"
else
	@echo "\033[93m$(TERM_SEPARATOR)"
	@echo "Mruby already downloaded. Skipping this step."
	@echo "$(TERM_SEPARATOR)\033[0m"
endif
	$(eval MRUBY_ROOT = $(HEXES_ROOT)/mruby)
