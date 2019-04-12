# To start the input framework `fcitx`.
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

# Keyboard remapping.
# # To make available, and set Compose.
setxkbmap -layout us -variant altgr-intl
# # To set PrtSc to be Compose (for umlauts for example).
setxkbmap -option "compose:prsc"
# # To exchange Caps Lock and Escape.
setxkbmap -option "caps:swapescape"

# To disable the touchpad.
xinput set-prop "Synaptics TM3289-002" "Device Enabled" 0

# To call Redshift, which adjusts the color temperature of your screen.
pgrep redshift &> /dev/null || redshift &> /dev/null &

# To call the package that stops the middle button to paste.
nohup xmousepasteblock &>/dev/null &

