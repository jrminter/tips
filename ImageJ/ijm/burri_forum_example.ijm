/**
 * Find green and purple-ish areas using the Lab color space.
 * 
 * Use plant.jpeg in /Users/jrminter/Documents/git/tips/jpg
 * 
 * 2019-06-29
 * 
 * By Olivier Burri for the Image.sc forum
 * https://forum.image.sc/t/need-help-with-coding-a-macro/27095?u=oburri
 */

 // Get some inputs using Script Parameters: https://imagej.net/Script_Parameters

#@ImagePlus input_image
#@Double sigma_blur( label = "Sigma for initial blurring", value = 2 )
#@String threshold( label = "Threshold Method", value = "Triangle" )


// We are blurring the image a little bit to avoid noise. 
selectImage( input_image );
Overlay.clear;
run("Select None");
close( "\\Others" );
run( "Duplicate...", "title=[Lab stack]" );
run( "Gaussian Blur...", "sigma="+sigma_blur);

// This converts the image to the Lab color space: https://sensing.konicaminolta.asia/what-is-cie-1976-lab-color-space/
// There is a Wikipedia page, but it's a bit more technical than I like
run( "Lab Stack" );

// Pick up the a* ad b* components
setSlice( 2 );	
run( "Duplicate...", "title=[a* Component]" );
selectImage( "Lab stack" );
setSlice( 3 );
run( "Duplicate...", "title=[b* Component]" );

// Because the stem seems to be bright in the a* component, we combine them to try and get the better plant
imageCalculator( "Max create", "a* Component","b* Component" );
rename( "Plant" );

// After this, we apply a threshold on the resulting image using an auto-method
setAutoThreshold( threshold+" dark" );
//run("Threshold...");
setOption( "BlackBackground", false );
run( "Convert to Mask" );

// Create a selection and overlay it on the original image
run( "Create Selection" );
selectImage( input_image );
run( "Restore Selection" );
Overlay.addSelection( "", 20, "#66ff4444" );
run("Select None");