# To start the input framework `fcitx`.
export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcitx"
export XMODIFIERS="@im=fcitx"

# To stop the middle button to paste.
nohup xmousepasteblock &>/dev/null &

# To call Redshift.
redshift &> /dev/null &

# Add ssh keys.
eval $(ssh-agent)
ssh-add

