// make scatterplot from red and green channels of 8 bit RGB image;
// from Jeremy Addler on the ImageJ mailing list 2019-06-13
print("\\Clear");
RGBID=getImageID();
wdth=getWidth();
ht=getHeight();
run("Split Channels");
BlueID=getImageID();
RedID=BlueID+2;
GrnID=BlueID+1;
// make scatterplot;
newImage("Scatterplot", "16-bit black", 256, 256, 1);// assumes 8 bit;
scatID=getImageID();
setBatchMode(1);
T0=getTime();// measure time;
Nmax=0; // max number in scatterplot;
for (x=0;x<wdth;x=x+1) {
  for (y=0;y<ht;y++){
selectImage(RedID);// X axis in scatterplot;
vRed=getPixel(x, y);
selectImage(GrnID);// Y axis in scatterplot;
vGrn=255-getPixel(x, y);// origin top left;
 selectImage(scatID);
 vScat=getPixel(vRed, vGrn);
 setPixel(vRed, vGrn, vScat+1);
 if (Nmax<vScat) Nmax=vScat; // track max entries;
}// y loop;
}// x loop;
Tend=getTime();
print("time ",Tend-T0," msecs");
print("max count in scatterplot ",Nmax);
setMinAndMax(0, Nmax/8); // display range
//setMinAndMax(0, 255);
run("16_colors");