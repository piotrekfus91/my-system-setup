#!/bin/bash

aptitude search '~U' > /tmp/listOfUpgrades 2>/tmp/listOfUpgrades.log
~/Programowanie/Bash/bin/update-config-repositories.sh
~/Programowanie/Bash/bin/update-apps.sh > /tmp/update-apps.log 2>&1