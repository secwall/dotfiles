#!/bin/bash

CUR=`cat /proc/acpi/battery/BAT0/state | grep remaining | cut -d: -f2 | sed s/^\ *//g | cut -d\  -f1`
MAX=`cat /proc/acpi/battery/BAT0/info | grep full | cut -d: -f2 | sed s/^\ *//g | cut -d\  -f1`
LEFT=`cat /sys/devices/platform/smapi/BAT0/remaining_running_time`
CHARGE=`cat /sys/devices/platform/smapi/BAT0/remaining_charging_time`

PRC=$(( CUR * 100 / MAX ))

STATE=`cat /proc/acpi/battery/BAT0/state | grep charging | cut -d: -f2 | sed -e 's/^\ *//g' -e "s/discharging/-\ \($LEFT\ mins\)/" -e 's/charged/=/' -e "s/charging/+\ \($CHARGE\ mins\)/"`

echo $STATE $PRC
