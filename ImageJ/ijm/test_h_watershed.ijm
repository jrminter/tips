// NOT impressed on blobs...
hMin = 20; // example 20
thresh = 100;  // example 100
peakFlooding = 90; // example 90
run("H_Watershed", "impin=["+getTitle()+"] hmin="+hMin+" thresh="+thresh+" peakflooding="+peakFlooding + " outputmask=true allowsplitting=false");