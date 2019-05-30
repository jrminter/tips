// https://imagej.nih.gov/ij/developer/macro/functions.html#List.setMeasurements
//
// List.setMeasurements - Measures the current image or selection and loads the
// resulting keys (Results table column headings) and values into the list.
// Use List.setMeasurements("limit") to measure using the "Limit to threshold" option.
// All parameters listed in the Analyze>Set Measurements dialog box are measured,
// including those that are unchecked. Use List.getValue() in an assignment statement
// to retrieve the values. See the DrawEllipse macro for an example.
//
// The string type should contain "8-bit", "16-bit", "32-bit" or "RGB".
// In addition, it can contain "white", "black" or "ramp" (the default is "white").
// As an example, use "16-bit ramp" to create a 16-bit image containing a grayscale ramp.
//
// See
// https://forum.image.sc/t/how-to-skip-this-error-java-lang-arrayindexoutofboundsexception-0-imagej-macro-error/26120
// "black" fails as expected...
// 
newImage("Untitled", "8-bit black", 100, 100, 1);
myID = getImageID();
resultOfProcessing=processImage(myID);
//if resultOfProcessing == 0 then failed to analyse
if(resultOfProcessing==0){
	print("found result that would divide by zero");
}else if(resultOfProcessing==-1){
	print("window ID "+ myID + " is no longer available");
}else{
	print("found range of "+resultOfProcessing);
}


function processImage(myImageID){
	if(!isOpen(myImageID)){
		return -1;
	}
	selectImage(myImageID);
	List.setMeasurements();
	myMin=List.getValue("Min");
	myMax=List.getValue("Max");
	myMean = List.getValue("Mean");
	if(myMin==0 && myMax == 0 && myMean==0){
		//skip image or return a value to indicate no result is avaliable
		return 0;
	}else{
		//process the image
		myRange = myMax / myMin;
		//return the result
		return myRange;
	}
}