setxkbmap -layout us,ru -option grp:caps_toggle,grp_led:caps

while :;
do
    rm -rf ~/Desktop
    sleep 5
done &

eval $(gpg-agent --daemon)
exec awesome
