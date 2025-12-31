PREFIX ?= /usr
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man/man1
DATADIR = $(PREFIX)/share/run-gcc

install:
	install -Dm755 src/run-gcc $(DESTDIR)$(BINDIR)/run-gcc
	install -Dm644 man/run-gcc.1 $(DESTDIR)$(MANDIR)/run-gcc.1
	# Install templates
	install -dm755 $(DESTDIR)$(DATADIR)/templates/c
	install -dm755 $(DESTDIR)$(DATADIR)/templates/cpp
	install -Dm644 pkg/templates/c/*.c $(DESTDIR)$(DATADIR)/templates/c/
	install -Dm644 pkg/templates/cpp/*.cpp $(DESTDIR)$(DATADIR)/templates/cpp/

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/run-gcc
	rm -f $(DESTDIR)$(MANDIR)/run-gcc.1
	rm -rf $(DESTDIR)$(DATADIR)/templates

test:
	bats tests/