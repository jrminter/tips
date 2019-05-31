// ImageJ macro to calculate the Radially Averaged Autocorrelation Function,
// Corrected for finite size effects
// The output is normalized to a value of 1 at zero radius
// and corrected for effects of the finite image size.
// (No need to extend the image size for avoiding edge effects)
//
// Use with a binary input image.
// Needs the last (2008-05-14) Version of the "Radial Profile Plot" plugin,
// http://rsb.info.nih.gov/ij/plugins/radial-profile.html
//
// Version: 2011-Sep-27 Michael Schmid: fixes bug when processing stack (normalization was wrong)
// Version: 2015-Feb-17 Michael Schmid: added missing Plot.show(); at the end
//
requires("1.42p");
run("Close All");
open("/Users/jrminter/Documents/git/tips/ImageJ/tif/POL-4455-16bit-Img01-bks.tif");
run("Median...", "radius=3");
doStack=false;
if (nSlices()>1) doStack = getBoolean("Get RDF from full stack?");
setBatchMode(true);
firstSlice=getSliceNumber();
lastSlice=getSliceNumber();
if (doStack) {
  firstSlice=1;
  lastSlice=nSlices();
}
width=getWidth;
height=getHeight;
getPixelSize(unit, pixelWidth, pixelHeight);
run("Select None");
//maxRadius may be modified, should not be larger than 0.3*minOf(width, height);
maxRadius=0.3*minOf(width, height);
minFFTsize=1.3*maxOf(width, height);
title=getTitle();
size=4;
while(size<minFFTsize) size*=2;
for (slice=firstSlice; slice<=lastSlice; slice++) {
  if (doStack) setSlice(slice);
  //make autocorrelation of particle image
  tempTitle="temp-"+random();
  run("Duplicate...", "title="+tempTitle);
  tempID=getImageID();
  getRawStatistics(nPixels, mean);
  run("Canvas Size...", "width="+ size+" height="+ size+" position=Center zero");
  makeRectangle(floor((size-width)/2), floor((size-height)/2), width, height);
  run("Make Inverse");
  run("Set...", "value="+mean);
  run("Select None");
  getRawStatistics(nPixels, mean);
  run("FD Math...", "image1=["+tempTitle+"] operation=Correlate image2=["+tempTitle+"] result=AutoCorrelation do");
  psID=getImageID();
  run("Subtract...", "value="+(nPixels*mean*mean));
  selectImage(tempID);
  close();

  //make autocorrelation reference to correct finite image size effects
  newImage("frame", "8-bit White", width, height, 1);
  run("Set...", "value=255");
  tempID=getImageID();
  rename(tempTitle);
  run("Canvas Size...", "width="+ size+" height="+ size+" position=Center zero");
  run("FD Math...", "image1=["+tempTitle+"] operation=Correlate image2=["+tempTitle+"] result=AutoCorrReference do");
  refID=getImageID();
  imageCalculator("Divide", psID,refID);
  selectImage(refID);
  close();
  selectImage(tempID);
  close();

  //prepare normalized power spectrum for radial averaging
  selectImage(psID);
//  makeRectangle(size/2, size/2, 1, 1);
//  run("Set...", "value=0");
//  run("Select None");
  circleSize=2*floor(maxRadius)+1;
//  run("Specify...", "width="+circleSize+" height="+circleSize+" x="+(size/2+0.5)+" y="+(size/2+0.5)+" oval centered");
//  getRawStatistics(nPixels, mean);
//  run("Select None");
//  run("Divide...", "value="+mean);
  norm = getPixel(size/2, size/2);
  run("Divide...", "value="+norm);
  run("Specify...", "width="+circleSize+" height="+circleSize+" x="+(size/2+0.5)+" y="+(size/2+0.5)+" oval centered");
  run("Radial Profile", "x="+(size/2+0.5)+" y="+(size/2+0.5)+" radius="+floor(maxRadius)-1);
  plotID=getImageID();
  Plot.getValues(x, y);
  if (slice==firstSlice) ySum = newArray(y.length);
  for (i=0; i<y.length; i++)
    ySum[i]+=y[i]/(lastSlice-firstSlice+1);
  selectImage(plotID);
  close();
  selectImage(psID);
  close();
}
setBatchMode("exit and display");
if (pixelWidth==pixelHeight) {
  for (i=0; i<x.length; i++)
    x[i] *= pixelWidth;
} else
  unit = "pixels";
if (doStack) title = title + " (stack)";
Plot.create("Autocorrelation of "+title, "Distance ("+unit+")", "Normalized Autocorrelation", x, ySum);
Plot.show();


run("Clear Results");
Plot.getValues(xpoints, ypoints);
for (i=0; i<xpoints.length; i++) {
  setResult("R", i, xpoints[i]);
  setResult("AC", i, ypoints[i]);
}

// selectWindow("Results");
// saveAs("Results", "/Users/jrminter/Documents/git/tips/ImageJ/tif/pol4455_acf.csv");

// Note: need to save data manually...