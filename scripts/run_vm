#!/bin/sh

choice=`vboxmanage list vms | awk -F'"' '{ print $2 }' | dmenu`

[ -z "$choice"] && notify-send "vm_menu" "no vm selected" || (vboxmanage startvm $choice || notify-send "vm_menu" "could not start vm: $choice")
