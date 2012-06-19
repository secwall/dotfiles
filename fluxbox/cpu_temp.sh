#!/bin/bash

cat /proc/acpi/ibm/thermal | cut -d: -f2 | cut -d\  -f1 | sed 's/^[ \t]*//'
