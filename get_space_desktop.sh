#!/bin/bash

# Get new objects at http://skyserver.sdss.org/dr7/en/tools/search/form/default.aspx
# See user guide at http://skyserver.sdss.org/dr7/en/tools/search/form/guide.asp#mags

# Convert 2 images to 1 using ImageMagick's command $convert.
# This is useful if your screen resolution is higher than SkyServer's resolution limit, 2048x2048

cd /home/maho/git/space_wall

pi=3.14159

len=$(($(cat objects.csv | wc -l) - 1))

end=$((SECONDS+60*60*8))

while [ $SECONDS -lt $end ]; do
    i=$((2+RANDOM%$len))
    
    printf "\nrow: $i\n"

    ra=$(sed -n "$i p" objects.csv | cut -d, -f 2)
    dec=$(sed -n "$i p" objects.csv | cut -d, -f 3)
    
    printf "ra: $ra\ndec: $dec\n"
    
    dra=$(echo "0.112/c($dec/180*$pi)" | bc -l)
    
    ra=$(echo "$ra+$dra" | bc)
    
    wget -nv -O "sdss_1.jpg" "http://skyserver.sdss.org/dr12/SkyserverWS/ImgCutout/getjpeg?ra=$ra&dec=$dec&width=2048&height=2048&scale=0.5"
    
    dra=$(echo "0.2534/c($dec/180*$pi)" | bc -l)
    
    ra=$(echo "$ra-$dra" | bc)

    wget -nv -O "sdss_2.jpg" "http://skyserver.sdss.org/dr12/SkyserverWS/ImgCutout/getjpeg?ra=$ra&dec=$dec&width=1592&height=2048&scale=0.5"
    
    convert "sdss_1.jpg" "sdss_2.jpg" +append "/home/maho/Pictures/Wallpapers/sdss.jpg"

    sleep 45s
    
done

