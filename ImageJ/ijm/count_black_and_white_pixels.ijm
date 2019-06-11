/* count_black_and_white_pixels.ijm
 *  
 * Counting black and white pixels
 *  
 * Based on this Forum post:
 * https://forum.image.sc/t/counting-black-and-white-pixels/5041/3
 * 
 * Date        Who  What
 * ----------  ---  ------------------------------------------------
 * 2019-06-11  JRM  Adapted Jerome's post to start clean and create
 *                  a test image, and output the back and white pixel
 *                  count. Used some ideas from here:
 *                  http://imagej.1557.x6.nabble.com/change-pixel-values-within-a-macro-tp5002663p5002664.html
 *                  From the size we can tell which is which...
 */

// start clean by closing the log and all images
print("\\Clear");
run("Close All");

// Construct the test image
newImage("test_image", "8-bit black", 512, 512, 1);

size = 50;
x_min = 256-(size/2);
y_min = 256-(size/2);

// Fill the ROI... This is the BF&I approach, but it works...
for(x=x_min;x<x_min+size;x++){ 
	for(y=y_min;y<y_min+size;y++){ 
		test=getPixel(x,y); 
		if(test==0){
			setPixel(x,y,255);
		}
	}
}

// Threshold the image
setThreshold(128,255);
setOption("BlackBackground", true);
run("Convert to Mask");
// Let the histogram do the work... 
getHistogram(values, counts, 2);
Array.print(counts);


