INSTALL_MANPATH		= /usr/local/man/man1
INSTALL_SCRIPTS_PATH	= /usr/local/bin

MANFILES		= nsplit.sh.1 \
			  cvsup-ports.sh.1 \
			  find_core_files.sh.1 \
			  find_broken_links.sh.1 \
			  stop_user_processes.sh.1 \
			  secure_firefox_cleanup.sh.1 \
			  secure_firefox_cleanup_osx.sh.1
SHELL_SCRIPTS		= nsplit.sh \
			  functions.sh \
			  cvsup-ports.sh \
			  find_core_files.sh \
			  find_broken_links.sh \
			  stop_user_processes.sh \
			  secure_firefox_cleanup.sh \
			  secure_firefox_cleanup_osx.sh

install: install_shells install_manpages

install_manpages: $(MANFILES)
	mkdir -p $(INSTALL_MANPATH)
	cp $(MANFILES) $(INSTALL_MANPATH)/.

install_shells: $(SHELL_SCRIPTS)
	cp $(SHELL_SCRIPTS) $(INSTALL_SCRIPTS_PATH)/.

purge:
	rm -rf *~
