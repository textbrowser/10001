INSTALL_MANPATH		= /usr/share/man/man1
INSTALL_SCRIPTS_PATH	= /usr/local/bin

MANFILES		= cvsup-ports.sh.1 \
			  find_broken_links.sh.1 \
			  find_core_files.sh.1 \
			  nsplit.sh.1 \
			  postgresql_backup.sh.1 \
			  recycle_swap.sh.1 \
			  secure_firefox_cleanup_osx.sh.1 \
			  secure_firefox_cleanup.sh.1 \
			  stop_user_processes.sh.1

SHELL_SCRIPTS		= cvsup-ports.sh \
			  find_broken_links.sh \
			  find_core_files.sh \
			  functions.sh \
			  man2pdf.sh \
			  nsplit.sh \
			  postgresql_backup.sh \
			  odt-reader.sh \
			  recycle_swap.sh \
			  secure_firefox_cleanup_osx.sh \
			  secure_firefox_cleanup.sh \
			  stop_user_processes.sh

install: install_manpages install_scripts

install_manpages: $(MANFILES)
	mkdir -p $(INSTALL_MANPATH)
	install $(MANFILES) $(INSTALL_MANPATH)

install_scripts: $(SHELL_SCRIPTS)
	install $(SHELL_SCRIPTS) $(INSTALL_SCRIPTS_PATH)

purge:
	rm -rf *~
