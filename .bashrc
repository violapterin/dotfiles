# `~/.bashrc` is loaded by an interactive non-login bash shell.

# Do nothing if not running interactively.
[[ $- != *i* ]] && return

# Load `.profile`, if it exists.
[ -r ~/.profile ] && source ~/.profile

# # # # # # # # Settings, exportation, sourcing # # # # # # # # 

# Command-line completion resp. using up and down arrow keys.
bind "\"\e[A\": history-search-backward"
bind "\"\e[B\": history-search-forward"

# To ignore case in completing commands.
bind "set completion-ignore-case On"

# To initialize the `bash-completion` package.
source /usr/share/bash-completion/bash_completion

# # # # # # # # File management # # # # # # # #

# When changing directory, always expand a symlink.
alias cd="cd -P"

# `ls` for hidden & short form; `Ls` unhidden & long form;
# `-G`: to enable colorized output;
# `-F`: to display a slash;
# `-h`: to use human readable format, e.g. KB, MB, GB,...;
# `-l`: to use long format, including permissions and date modified;
# `-a`: to display hidden files, say `.gitignore`
alias ls="ls -GFh --color"
alias Ls="ls -alGFh --color"

# Disk usage
alias Du="du -shc * | gsort -hr"

# # # # # # # # Other aliases for applications # # # # # # # #

# `cd` (change directory) shortcuts.
# Double quotes ensures they are passed as a single token.
alias CdEssays="cd \"${CLOUD}/Chinese_writing/Chinese_essays/part_8_since_Jan_2017\""
alias CdArchive="cd \"${CLOUD}/Chinese_writing/authentic_archive\""
alias CdMusicWork="cd \"${CLOUD}/music_composition\""
alias CdScienceWork="cd \"${CLOUD}/science_work\""
alias CdRepos="cd \"${CLOUD}/code_repos\""
alias CdBooks="cd \"${CLOUD}/books\""

# To browse PTT.
alias BrowsePtt="ssh bbsu@ptt.cc"
# To browse PTT2.
alias BrowsePtt2="ssh bbsu@ptt2.cc"

# To edit with neovim.
alias V="nvim"

# NTU VPN. Assume Pulse Secure CLI client is installed.
NTUVPN()
{
   local pw
   printf "Password: "
   read pw
   pulsesvc -h "sslvpn2.ntu.edu.tw" -u "r05942142" -p "${pw}" -r "NTU EMail Account" -U "https://sslvpn2.ntu.edu.tw/" &
}


