selectWindow("POL-4455-16bit-Img01-bks.tif");
run("Median...", "radius=2");
run("Invert");
saveAs("PNG", "/Users/jrminter/Documents/git/tips/ImageJ/png/POL-4455-16bit-Img01-bks-mf_inv.png");
