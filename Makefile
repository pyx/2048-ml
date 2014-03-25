# Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
# All rights reserved.
# License: BSD New, see LICENSE for details.

PROGRAM = 2048.ml
BUILD_DIR = _build
SRC_DIR = src

TARGET = main
DEBUG_TARGET = $(TARGET).byte
RELEASE_TARGET = $(TARGET).native

RELEASE_BUILD_OUTPUT = $(BUILD_DIR)/$(SRC_DIR)/$(RELEASE_TARGET)

# install dest.
prefix ?= /usr/local
exec_prefix ?= $(prefix)
bindir ?= $(exec_prefix)/bin

SRC = $(wildcard $(realpath $(SRC_DIR))/*.mli) $(wildcard $(realpath $(SRC_DIR))/*.ml)
FLAGS = -I $(SRC_DIR) -cflags "-w A-4-33-40-41-42-43-34-44" -cflag -strict-sequence -cflag -annot
DEBUG_FLAGS = -cflag -g
LIBS = -libs graphics
OCAMLBUILD = ocamlbuild

.PHONY: all debug release run install uninstall clean

all: release

debug: $(SRC)
	$(OCAMLBUILD) $(FLAGS) $(DEBUG_FLAGS) $(LIBS) $(SRC_DIR)/$(DEBUG_TARGET)

release: $(SRC)
	$(OCAMLBUILD) $(FLAGS) $(LIBS) $(SRC_DIR)/$(RELEASE_TARGET)

run: debug
	./$(DEBUG_TARGET)

install: release
	install -d $(DESTDIR)$(bindir)
	install -m 0755 $(RELEASE_BUILD_OUTPUT) $(DESTDIR)$(bindir)/$(PROGRAM)

uninstall:
	-rm $(DESTDIR)$(bindir)/$(PROGRAM)

clean:
	$(OCAMLBUILD) -clean
