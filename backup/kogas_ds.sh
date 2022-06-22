#!/bin/bash

# Setting to stop while loop
finish=0
trap 'finish=1' SIGUSR1

# Remove all files except mp4 format
find './data' -type f \! -iname '*mp4*' -delete

# Remove old video files, only latest 30 files should exist
cd './data' 
pwd
rm `ls -t './' |  awk 'NR>30'`
cd ../
pwd
while (( finish != 1 ))
do
        curl --head --connect-timeout 1 -i -X OPTIONS admin:nonia8123\!@192.168.10.100:554/profile1/media.smp

	while [ $? -ne 8 ]
        do
	        curl --head --connect-timeout 1 -i -X OPTIONS admin:nonia8123\!@192.168.10.100:554/profile1/media.smp
        done

	curl --head --connect-timeout 1 -i -X OPTIONS admin:nonia8123\!@192.168.10.101:554/profile1/media.smp

	while [$? -ne 8 ]
	do
		curl --head --connect-timeout 1 -i -X OPTION admin:nonia8123\!@192.168.10.101:554/profile1/media.smp
	done

        ../apps/sample_apps/deepstream-app/deepstream-app -c ./kogas_yoloV3.txt
done
