// kota_embryo_example.ijm
// From slide 71 in 20190622_DefendBioimageAnalysis_Kota.pdf
//
// Typed in by J. R. Minter with modifications noted in comments
// 2019-06-23

// Start Clean
run("Close All");

// Open the original image
run("Embryos (42K)");
// I measured the 100 um scale bar
run("Properties...", "channels=1 slices=1 frames=1 unit=µm pixel_width=0.2111931 pixel_height=0.2111931 voxel_depth=0.2111931");


// extract the first embryo
selectWindow("embryos.jpg");
makeRectangle(658, 570, 122, 127);
run("Duplicate...", " ");

// extract the second embryo
selectWindow("embryos.jpg");
makeRectangle(1012, 714, 122, 127);
run("Duplicate...", " ");

// combine two embryos side-by-side
run("Combine...", "stack1=embryos-1.jpg stack2=embryos-2.jpg");

// insert white bar between embryos
run("Specify...", "width=3 height=127 x=121 y=0");
run("Colors...", "foreground=white background=black selection=green");
setForegroundColor(255, 255, 255);
run("Fill", "slice");
// finish
// JRM add a scale bar
run("Scale Bar...", "width=5 height=4 font=14 color=White background=None location=[Lower Right] bold overlay");
run("Select None");
