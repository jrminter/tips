//
// jrm_radial_profile_extended_.py
//
// Adapted from: https://gist.github.com/miura/e31ae2cc70800785ece7ae7a6b28554e
// needs: https://imagej.nih.gov/ij/plugins/radial-profile-ext.html

run("Close All");
open("/Users/jrminter/dat/images/key-test/other/poster/CC1088-194A-g1-01cr.bmp");
run("8-bit", "");
run("Invert", "");
run("Radial Profile Angle", "x_center=320.0 y_center=320.0 radius=320.0 starting_angle=0 integration_angle=180");
run("Clear Results");
for(j = 0; j < Ext.getBinSize; j++){
	setResult("Radius", j, Ext.getXValue(j)); 
	setResult("Intensity", j, Ext.getYValue(0, j)); 
}
updateResults(); 
saveAs("results", "");