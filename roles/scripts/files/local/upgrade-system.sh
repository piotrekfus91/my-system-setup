#!/bin/bash

sudo aptitude upgrade
aptitude search '~U' > /tmp/listOfUpgrades
