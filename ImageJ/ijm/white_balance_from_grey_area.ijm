// white_balance_from_grey_area.ijm
// by Jerome Mutterer 2019-06-04
// from https://gist.github.com/mutterer/819909745278f2160d820d2d80bf7a42
// based on this Forum post:
// https://forum.image.sc/t/normalization-of-true-white-to-compare-pigment-across-images/26322/4
//
setBatchMode(1);
t=getTitle();
getBoundingRect(x, y, width, height);
run("Select None");
run("Duplicate..." , "title=ori duplicate");
makeRectangle(x, y, width, height);
run("RGB Stack");
run("32-bit");
id=getImageID;
run("Duplicate..." , "title=temp duplicate");
run("Gaussian Blur...", "radius=1 stack");
m = newArray(3);
for (c=0;c<3;c++) {
  setSlice(c+1);
  getRawStatistics(nPixels, mean, min, max, std, histogram);
  m[c]=mean;
}
Array.getStatistics(m, min, max, mean, stdDev);
selectImage(id);
run("Select None");
for (c=0;c<3;c++) {
  setSlice(c+1);
  f = max/m[c];
  run("Multiply...", "value=&f");
}
run("8-bit");
run("RGB Color");
rename ("WB_"+t);
setBatchMode(0);