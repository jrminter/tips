/*
* Macro to count nuclei in multiple images in a folder/subfolders.
*/

#@File(label = "Input directory", style = "directory") input
#@File(label = "Output directory", style = "directory") output
#@String(label = "File suffix", value = ".tif") suffix
#@int(label = "Minimum size") minSize

processFolder(input);
	
// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	list = getFileList(input);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i]))
			processFolder("" + input + File.separator + list[i]);
		if(endsWith(list[i], suffix))
			processFile(input, output, list[i]);
	}
	//saves results for all images in a single file
	saveAs("Results", output + "/All_Results.csv"); 
}

function processFile(input, output, file) {
	setBatchMode(true); // prevents image windows from opening while the script is running
	// open image using Bio-Formats
	run("Bio-Formats", "open=[" + input + "/" + file +"] autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
  id = getImageID(); // get original image id
	run("Duplicate...", " "); // duplicate original image and work on the copy
	
	// create binary image
	run("Gaussian Blur...", "sigma=2");
	setAutoThreshold("Default dark");
	//run("Threshold...");
	run("Create Mask");
	run("Watershed");
	// save current binary image
	save(output + "/Binary_OUTPUT_" + file);
	
	run("Analyze Particles...", "size=" + minSize + "-Infinity exclude add");
  selectImage(id); // activate original image
  roiManager("Show All with labels"); // overlay ROIs
	roiManager("Deselect");
	roiManager("Measure"); // measure on original image
	
	// save ROIs for current image
	roiManager("Deselect");
	roiManager("Save", output+ "/" + file + "_ROI.zip"); // saves Rois zip file
	roiManager("Deselect");
	roiManager("Delete"); // clear ROI Manager for next image
}