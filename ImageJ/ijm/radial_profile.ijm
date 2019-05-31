// plot the radial profile of POL4455
//
// 2019-05-31 J. R. Minter
//
// uses plugin Radial_Profile.class in plugins folder
// Source: https://imagej.nih.gov/ij/plugins/download/Radial_Profile.class
// Written by Paul Baggethun. Last reported edit: 2009-05-14
// see also: https://imagejdocu.tudor.lu/doku.php?id=macro:radial_distribution_function
//

run("Close All");
open("/Users/jrminter/Documents/git/tips/ImageJ/tif/POL-4455-16bit-Img01-bks.tif");
run("Median...", "radius=4");
makeRectangle(0, 0, 1024, 1024);
//run("Radial Profile", "x=512 y=512 radius=512");
run("Radial Profile", "x=512 y=512 radius=512 use"); // use scale 
saveAs("Results", "/Users/jrminter/Documents/git/tips/ImageJ/ijm/radial_profile_pol4455.csv");