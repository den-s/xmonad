setxkbmap -layout "us,ru"
setxkbmap -option "grp:caps_toggle,grp_led:caps"

xsetroot -cursor_name left_ptr &

export PATH=~/bin/:$PATH

exec trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 6 --transparent true --alpha 0 --tint 0x000000 --height 16 &

exec dbus-launch xmonad
