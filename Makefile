GUILE_ENV_VARS=GUILE_LOAD_PATH=$(HOME)/.config/guix/current/share/guile/site/3.0/:./src:$(GUILE_LOAD_PATH)
GUIX=$(GUILE_ENV_VARS) guix

# Update profile
profile:
	@guix pull --channels=channels.scm

# Update profile only if necessary.
maybe-profile:
	@if [ ! -d "$(HOME)/.config/guix/current" ]; then \
	make profile; \
	fi

# Reconfigure home
home: maybe-profile
	@RDE_TARGET=home \
	$(GUIX) home reconfigure config.scm

# Reconfigure system
# TODO: Change `sudo` to smth like `SUDO_OR_DOAS` maybe
system: maybe-profile
	@RDE_TARGET=system \
	sudo $(GUIX) system reconfigure config.scm

system/shepherd-graph:
	@RDE_TARGET=system \
	sudo $(GUIX) system shepherd-graph config.scm

# Start REPL with this configuration
repl: maybe-profile
	@$(GUIX) repl -i config.scm
