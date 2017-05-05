# This is `.bash_profile`, which an interactive login shell loads.

# Make `.bash_profile` load .bashrc, if it exists.
FULL_BASHRC="/Users/amino/Google_drive/templates_configs_scripts/configuration_files/.bashrc"
[ -r ${FULL_BASHRC} ] && source ${FULL_BASHRC}

export PATH=$PATH:/Users/amino/Google_drive/templates_configs_scripts/scripts
