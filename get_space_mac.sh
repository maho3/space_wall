#!/bin/bash

# Get new objects at http://skyserver.sdss.org/dr7/en/tools/search/form/default.aspx
# See user guide at http://skyserver.sdss.org/dr7/en/tools/search/form/guide.asp#mags

# Convert 2 images to 1 using ImageMagick's command $convert.
# This is useful if your screen resolution is higher than SkyServer's resolution limit, 2048x2048

# Creates N objects in a folder, to be randomly displayed by MacOS

# cd /Users/maho/git/space_wall

pi=3.14159

len=$(($(cat objects.csv | wc -l) - 1))

N=50

counter=0

while [ $counter -le $N ]; do
    i=$((2+RANDOM%$len))
    
    printf "\nrow: $i\n"

    ra=$(sed -n "$i p" objects.csv | cut -d, -f 2)
    dec=$(sed -n "$i p" objects.csv | cut -d, -f 3)
    
    printf "ra: $ra\ndec: $dec\n"
    
    dra=$(echo "0.0788/c($dec/180*$pi)" | bc -l)
    
    ra=$(echo "$ra+$dra" | bc)
    
    curl -s "http://skyserver.sdss.org/dr12/SkyserverWS/ImgCutout/getjpeg?ra=$ra&dec=$dec&width=1440&height=1600&scale=0.5" \
    -o "/Users/maho/git/space_wall/sdss_1.jpg"
    
    
    dra=$(echo "0.1782/c($dec/180*$pi)" | bc -l)
    
    ra=$(echo "$ra-$dra" | bc)

    curl -s "http://skyserver.sdss.org/dr12/SkyserverWS/ImgCutout/getjpeg?ra=$ra&dec=$dec&width=1120&height=1600&scale=0.5"\
    -o "/Users/maho/git/space_wall/sdss_2.jpg"
    
    convert "/Users/maho/git/space_wall/sdss_1.jpg" \
    "/Users/maho/git/space_wall/sdss_2.jpg" +append \
    "/Users/maho/Pictures/sdss/sdss_"$counter".jpg"

    ((counter++))
    
done

