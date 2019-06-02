gitHome = "C:/Users/jrminter/Documents/git";
relPath = "tips/ImageJ/png";
imgName = "Gold_no_overlay";
imgProcName = "Gold_w_overlay";
imgExt = ".png";
imgPath = gitHome + "/" + relPath + "/" + imgName + imgExt;
imgProcPath = gitHome + "/" + relPath + "/" + imgProcName + imgExt;
csvPath = gitHome + "/" + relPath + "/" + imgName + ".csv";
pltPath = gitHome + "/" + relPath + "/" + imgName + "_distn" + imgExt;

// leave as false to look at particle by particle results...
close_last = false
run("Close All");
// print(imgPath);
open(imgPath);
//  run("Settings Manager");
run("Particle Sizer");
selectWindow("Results");
saveAs("Results", csvPath);
// do not run after you get it right. Seems to change unexpectedly...
//setTool("rectangle");
selectWindow("Size Distribution for " + imgName + imgExt);
saveAs("PNG", pltPath);
selectWindow(imgName + "_distn" + imgExt);
close();
selectWindow(imgName + imgExt);
run("Flatten");
saveAs("PNG", imgProcPath);
selectWindow(imgProcName + imgExt);
close();
if (close_last) {
	selectWindow(imgName + imgExt);
	close();
	selectWindow("Results");
	close();
}
