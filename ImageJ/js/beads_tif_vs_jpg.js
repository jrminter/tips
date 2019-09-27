// demonstrate problems with jpg correction
// 2019-09-27 by jrminter
importClass(Packages.ij.IJ);
importClass(Packages.ij.plugin.ImageCalculator);
importClass(Packages.ij.WindowManager);
//
IJ.run("Close All");
base_path = "/Users/jrminter/Documents/git/tips/ImageJ";
tif_path = "/tif/color_beads.tif";
jpg_path = "/jpg/color_beads.jpg";
imp_tif = IJ.openImage(base_path + tif_path);
imp_tif.show();
IJ.run(imp_tif, "In [+]", "");
imp_tif.show();
imp_jpg = IJ.openImage(base_path + jpg_path);
imp_jpg.show();
IJ.run(imp_jpg, "In [+]", "");
imp_jpg = IJ.openImage(base_path + jpg_path);
imp_jpg.show();

ic = new ImageCalculator();
imp1 = WindowManager.getImage("color_beads.tif");
imp2 = WindowManager.getImage("color_beads.jpg");
imp3 = ic.run("Subtract create 32-bit", imp1, imp2);
imp3.show();
IJ.run(imp3, "In [+]", "");
imp3.show();
