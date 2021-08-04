INSTALL_MANUALS_PATH	= /usr/share/man/man1/10001
INSTALL_SCRIPTS_PATH	= /usr/local/bin/10001

MANUALS		= cvsup_ports.sh.1 \
		  find_broken_links.sh.1 \
		  find_consecutive_empty_lines.bash.1 \
		  find_core_files.sh.1 \
		  freebsd-update.8 \
		  maestro_debian.bash.1 \
		  nsplit.sh.1 \
		  postgresql_backup.sh.1 \
		  recycle_swap.sh.1 \
		  secure_firefox_cleanup_osx.sh.1 \
		  secure_firefox_cleanup.sh.1 \
		  stop_user_processes.sh.1

SHELL_SCRIPTS	= cvsup_ports.sh \
		  find_broken_links.sh \
		  find_consecutive_empty_lines.bash \
		  find_core_files.sh \
		  freebsd-update.sh \
		  functions.sh \
		  maestro_debian.bash \
		  man2pdf.sh \
		  nsplit.sh \
		  odt_reader.sh \
		  postgresql_backup.sh \
		  recycle_swap.sh \
		  secure_firefox_cleanup.sh \
		  secure_firefox_cleanup_osx.sh \
		  stop_user_processes.sh \
		  user_home_directories.bash

install: install_manuals install_scripts

install_manuals: $(MANUALS)
	mkdir -p $(INSTALL_MANUALS_PATH)
	install $(MANUALS) $(INSTALL_MANUALS_PATH)

install_scripts: $(SHELL_SCRIPTS)
	mkdir -p $(INSTALL_SCRIPTS_PATH)
	install $(SHELL_SCRIPTS) $(INSTALL_SCRIPTS_PATH)

purge:
	rm -rf *~
