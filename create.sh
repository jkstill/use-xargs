#!/bin/bash

# create a bunch of nested directories
# create a bunch of zero byte files in each directory
# time the difference between find -exec rm and xargs


level_1=1
# maxdirs**3 * maxfiles = total filecount
maxdirs=10
maxfiles=200

(( total_file_count = maxdirs**3 * maxfiles ))


echo Creating $total_file_count files...

XARGSDIR=/home/jkstill/use-xargs

while [ $level_1 -le $maxdirs ] # [
do
	cd $XARGSDIR >/dev/null
	currdir=$(pwd)
	#echo currdir: $currdir
	[ "$currdir" != "$XARGSDIR" ] && {
		pwd
		echo wrong dir
		exit 1
	}

	level_1_dir="LVL1-${level_1}"
	mkdir -p $level_1_dir
	cd $level_1_dir >/dev/null

	# level 2
	#echo LEVEL_2: $level_2
	#echo MAXDIRS: $maxdirs
	level_2=1

	while [ $level_2 -le $maxdirs ] # [
	do
		level_2_dir="LVL2-${level_2}"
		mkdir -p $level_2_dir
		cd $level_2_dir >/dev/null

		# level 3
		level_3=1
		while [ $level_3 -le $maxdirs ] # [
		do
			level_3_dir="LVL3-${level_3}"
			mkdir -p $level_3_dir
			cd $level_3_dir >/dev/null
			filecount=1

			while [ $filecount -le $maxfiles ] # [
			do
				filename="file_${filecount}"
				touch $filename
				(( filecount++ ))
			done # ]
			cd .. >/dev/null
			(( level_3++ ))

		done # ]
		cd .. >/dev/null
		(( level_2++ ))
		
	done # ]
	(( level_1++ ))
done # ]


