# space_wall
Downloads random galaxy images from SDSS's skyserver. Saves them as jpgs. Used to make space wallpapers.
## SDSS SkyServer
SDSS provides [a convenient api](http://skyserver.sdss.org/dr12/en/help/docs/api.aspx) for accessing jpg images of their data. It allows you to submit GET or POST requests to SkyServer to download color-corrected sky images. I wrote a bash script to query SkyServer every minute for a new image. I put the image in my Wallapapers/ folder and direct my linux boot to grab it from that file location.

SkyServer requires specified RA (right ascension) and DEC (declination) angles, as well as resolution imformation. You can get these for objects like stars, galaxies, and quasars from their [Search Form](http://skyserver.sdss.org/dr7/en/tools/search/form/default.aspx). I like pictures of nearby galaxies, so I grabbed a list of bright galaxies within the redshift range 0 < z < 0.01. I then query SkyServer for these galaxies' RA and DEC.

The maximum resolution for a single GET request from SkyServer is 2048x2048 px.

## Laptop
My Asus laptop resolution is 1920x1080, well within the bounds of a single GET request from SkyServer. Therefore, 'get_space_laptop.sh' is simply a matter of parsing the csv output from the Search Form and submitting a GET request from wget.

## Desktop
My desktop's resolution is 3840x2160. I wanted to download two, adjacent images and patch them together to create seamless 4k wallpapers. Therefore, get_space_desktop.sh includes some extra math in calculating how to distance these two images to ensure there is no gap/overlap between them. This took some manual tweaking to get the patch line perfect. Note, each image (at a given scale) covers the same arc area, so I had to do some simple trigonometry to account for how the arc area changes at different DEC. 

Once I have the two images, I patch them together using [ImageMagick's convert +append function](http://www.imagemagick.org/Usage/layers/#append). 

## Mac
My Macbook Pro's resolution is 2560x1600. I used the same image patching procedure as my desktop code, but with modified parameters to account for the lower resolution.

Instead of dynamically overwriting the same wallpaper jpg file, my mac script creates N images to be stored in a folder. I then direct MacOS to randomly change my wallpaper from images in this folder. I can make a new batch of images by re-running the mac script.