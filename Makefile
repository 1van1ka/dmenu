include config/config.mk

SRC_DIR   = src
OBJ_DIR   = build
INC_DIR   = include
SCRIPT_DIR = scripts
MAN_DIR   = man

SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS))

BINARIES = dmenu stest

all: $(OBJ_DIR)/dmenu $(OBJ_DIR)/stest

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) -I$(INC_DIR) -c $(CFLAGS) $< -o $@

$(OBJ_DIR)/dmenu: $(OBJ_DIR)/dmenu.o $(OBJ_DIR)/drw.o $(OBJ_DIR)/util.o
	$(CC) -o $@ $^ $(LDFLAGS)

$(OBJ_DIR)/stest: $(OBJ_DIR)/stest.o
	$(CC) -o $@ $^ $(LDFLAGS)

clean:
	rm -f $(OBJ_DIR)/*.o $(OBJ_DIR)/dmenu $(OBJ_DIR)/stest dmenu-$(VERSION).tar.gz *.rej *.orig

dist: clean
	mkdir -p dmenu-$(VERSION)
	cp -r LICENSE Makefile README config config.mk $(MAN_DIR) $(INC_DIR) $(SCRIPT_DIR) $(SRC_DIR) dmenu-$(VERSION)
	tar -cf dmenu-$(VERSION).tar dmenu-$(VERSION)
	gzip dmenu-$(VERSION).tar
	rm -rf dmenu-$(VERSION)

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f $(OBJ_DIR)/dmenu $(OBJ_DIR)/stest $(SCRIPT_DIR)/dmenu_* $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenu*
	chmod 755 $(DESTDIR)$(PREFIX)/bin/stest
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < $(MAN_DIR)/dmenu.1 > $(DESTDIR)$(MANPREFIX)/man1/dmenu.1
	sed "s/VERSION/$(VERSION)/g" < $(MAN_DIR)/stest.1 > $(DESTDIR)$(MANPREFIX)/man1/stest.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/*.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dmenu \
		$(DESTDIR)$(PREFIX)/bin/dmenu_path \
		$(DESTDIR)$(PREFIX)/bin/dmenu_run \
		$(DESTDIR)$(PREFIX)/bin/dmenu_drun \
		$(DESTDIR)$(PREFIX)/bin/stest \
		$(DESTDIR)$(MANPREFIX)/man1/dmenu.1 \
		$(DESTDIR)$(MANPREFIX)/man1/stest.1

$(OBJS): $(INC_DIR)/arg.h $(INC_DIR)/config.h $(INC_DIR)/drw.h $(INC_DIR)/util.h

.PHONY: all clean dist install uninstall
