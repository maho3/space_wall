#!/bin/bash

# Get new objects at http://skyserver.sdss.org/dr7/en/tools/search/form/default.aspx
# See user guide at http://skyserver.sdss.org/dr7/en/tools/search/form/guide.asp#mags


cd /home/annam/Desktop/git/space_wall

len=$(($(cat objects.csv | wc -l) - 1))

end=$((SECONDS+60*60*8))

while [ $SECONDS -lt $end ]; do
    i=$((2+RANDOM%$len))
    
    printf "\nrow: $i\n"

    ra=$(sed -n "$i p" objects.csv | cut -d, -f 2)
    dec=$(sed -n "$i p" objects.csv | cut -d, -f 3)

    wget -nv -O "/home/annam/Pictures/Wallpapers/sdss.jpg" "http://skyserver.sdss.org/dr12/SkyserverWS/ImgCutout/getjpeg?ra=$ra&dec=$dec&width=1920&height=1080"

    sleep 30s
    
done
