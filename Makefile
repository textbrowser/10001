INSTALL_MANUALS_PATH = /usr/share/man/man1/10001
INSTALL_SCRIPTS_PATH = /usr/local/bin/10001
MANUALS	= *.1
SHELL_SCRIPTS = *.bash *.sh

install: install_manuals install_scripts

install_manuals: $(MANUALS)
	mkdir -p $(INSTALL_MANUALS_PATH)
	install $(MANUALS) $(INSTALL_MANUALS_PATH)
	chmod -x $(INSTALL_MANUALS_PATH)/*.1

install_scripts: $(SHELL_SCRIPTS)
	mkdir -p $(INSTALL_SCRIPTS_PATH)
	install $(SHELL_SCRIPTS) $(INSTALL_SCRIPTS_PATH)

purge:
	rm -f *~
