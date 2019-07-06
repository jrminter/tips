/*
 * Macro template to process multiple images in a folder
 */

#@ File (label = "Input directory", style = "directory") input
#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = ".tif") suffix

processFolder(input);

// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(endsWith(list[i], suffix))
			processFile(input, output, list[i]);
	}
}

function processFile(input, output, file) {
	// Do the processing here by adding your own code.
	// Leave the print statements until things work, then remove them.
	print("Processing: " + input + File.separator + file);
	open(input + File.separator + file);

	//-- Record the filename
	imageName=getTitle();
	//-- Display the stack in greyscale, create an RGB version, rename
	Stack.setDisplayMode("grayscale");
	run("RGB Color");
	rename("channels");
	//-- Select the original image
	selectWindow(imageName);
	//-- Display the stack in composite, create an RGB version, rename
	Stack.setDisplayMode("composite");
	run("RGB Color");
	rename("merge");
	//-- Close the original
	close(imageName);
	//-- Put the two RGB images together
	run("Concatenate...", "  title=newStack open image1=channels image2=merge");
	//-- Create a montage
	run("Make Montage...", "columns=4 rows=1 scale=0.50 border=3");
	//-- Close the stack (from concatenation)
	close("newStack");
	print("Saving to: " + output);
	saveAs("png", output + File.separator + replace(file, suffix, ".png"));
	close("*");
}
