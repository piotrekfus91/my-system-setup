#!/bin/bash -e

year=`date +%Y`
month=`date +%m`

baseDir=~/grive/Dokumenty/$year/$month
baseDgDir=~/grive/e-bestum/Dokumenty/$year/$month

subdirs="mBank Orange UPC"
for subdir in $subdirs ; do
	mkdir -p $baseDir/$subdir
done

dgSubdirs="Faktury mBank ZUS US"
for dgSubdir in $dgSubdirs ; do
	mkdir -p $baseDgDir/$dgSubdir
done
