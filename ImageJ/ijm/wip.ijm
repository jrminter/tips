run("Close All");
open("/Users/jrminter/Documents/git/tips/ImageJ/png/small_rgb_bubbles.png");
rename("small_rgb_bubbles");
run("Split Channels");
selectWindow("small_rgb_bubbles (red)");
rename("small_rgb_bubbles_r");
selectWindow("small_rgb_bubbles (green)");
rename("small_rgb_bubbles_g");
selectWindow("small_rgb_bubbles (blue)");
rename("small_rgb_bubbles_b");

selectWindow("small_rgb_bubbles_r");
run("Duplicate...", "title=red_bkg");
selectWindow("red_bkg");
run("Gaussian Blur...", "sigma=50");
imageCalculator("Divide create 32-bit", "small_rgb_bubbles_r","red_bkg");
selectWindow("Result of small_rgb_bubbles_r");
setOption("ScaleConversions", true);
run("8-bit");
rename("small_rgb_bubbles_r_bks");

selectWindow("small_rgb_bubbles_g");
run("Duplicate...", "title=green_bkg");
selectWindow("green_bkg");
run("Gaussian Blur...", "sigma=50");
imageCalculator("Divide create 32-bit", "small_rgb_bubbles_g","green_bkg");
selectWindow("Result of small_rgb_bubbles_g");
setOption("ScaleConversions", true);
run("8-bit");
rename("small_rgb_bubbles_g_bks");

selectWindow("small_rgb_bubbles_b");
run("Duplicate...", "title=blue_bkg");
selectWindow("blue_bkg");
run("Gaussian Blur...", "sigma=50");
imageCalculator("Divide create 32-bit", "small_rgb_bubbles_b","blue_bkg");
selectWindow("Result of small_rgb_bubbles_b");
setOption("ScaleConversions", true);
run("8-bit");
rename("small_rgb_bubbles_b_bks");

selectWindow("blue_bkg");
close();
selectWindow("red_bkg");
close();
selectWindow("green_bkg");
close();

selectWindow("small_rgb_bubbles_r");
close();
selectWindow("small_rgb_bubbles_g");
close();
selectWindow("small_rgb_bubbles_b");
close();

run("Merge Channels...", "c1=small_rgb_bubbles_r_bks c2=small_rgb_bubbles_g_bks c3=small_rgb_bubbles_b_bks create");
run("Undo");
selectWindow("Composite");
run("Flatten");
rename("small_rgb_bubbles_bks");
selectWindow("small_rgb_bubbles_bks");
