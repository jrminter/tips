/*  JRM version of Thorsten Wagner's HAADF.ijm macro
 *
 *  2019-05-25 JRM start cleanup, including fixing spelling errors.
 *             The key to using this was to set ndef.noPlotting to true
 *             in ij.Prefs (in /Users/jrminter/Library/IJ_Prefs.txt)
 *             
 *             Note that the Plugin works properly on the mac when the
 *             ndef.noPlotting is set to true in IJ_Prefs.txt
 *
 *  Macro for analysis of STEM images of touching circular particles.
 *  1. Denoising my Non-Local-Means
 *  2. Subtract background with Rolling Ball Algorithm (Fixed radius if 150)
 *  4. Homogenize by median filter (radius 2)
 *  5. Thresholding by local thresholding method ("Phansalkar")
 *  6. Cut overlapping objects using watershed segmentation
 *  7. Smooth the contour of each particle using the first four Fourier descriptors
 *  8. Some objects can overlap again, so do the watershed segmentation a second time.
 */


/*
 * Get settings from setting manager (-1 = NanoDefine Default)
 */
var segLocalRBR = parseInt(call("ij.Prefs.get", "ndef.rollingBallRadius","-1")); 		//Rolling Ball Radius

// Shape constraints			
var filterMinSize = parseInt(call("ij.Prefs.get", "ndef.minSize","0"));
var filterMinFeretMin = parseInt(call("ij.Prefs.get", "ndef.minFeretMin","-1"));		// Minimum Feret Min Diameter [-1=NanoDefine Dafault (10px)]
var filterSolidity  = parseFloat(call("ij.Prefs.get", "ndef.filterSolidity","0"));
var filterConvexity = parseFloat(call("ij.Prefs.get", "ndef.convexity","0"));

// Ellipse constraints
var filterEllipseMinLongLength = parseInt(call("ij.Prefs.get", "ndef.minEllipseLongAxis","5"));
var filterEllipseMinShortLength = parseInt(call("ij.Prefs.get", "ndef.minEllipseShortAxis","5"));
var filterEllipseMaxAspectRatio = parseInt(call("ij.Prefs.get", "ndef.minEllipseAspectRatio","100"));

var objectIntensityThreshold = parseInt(call("ij.Prefs.get", "ndef.objectIntensityThreshold","16"));
var localThresholdWindowSize = parseInt(call("ij.Prefs.get", "ndef.localThresholdWindowSize","-1"));
var smoothingFactor = parseInt(call("ij.Prefs.get", "ndef.smoothingFactor","1"));
var doSelectRegion =  (toLowerCase(call("ij.Prefs.get", "ndef.doSelectRegion","true"))=="true");
var doIrregularWatershed = (toLowerCase(call("ij.Prefs.get", "ndef.doIrregularWatershed","false"))=="true");
var irregularWatershedConvexityThreshold = parseFloat(call("ij.Prefs.get", "ndef.ConvexityThreshold","0.7"));
var singeParticleMode = (toLowerCase(call("ij.Prefs.get", "ndef.useSingleParticleMode","false"))=="true");
var ellipseFittingMode = (toLowerCase(call("ij.Prefs.get", "ndef.useEllipseFittingMode","false"))=="true");
var binaryMode = (toLowerCase(call("ij.Prefs.get", "ndef.showBinaryResult","false"))=="true");
var noPlot = (toLowerCase(call("ij.Prefs.get", "ndef.noPlotting","false"))=="true");
var noDenoise = (toLowerCase(call("ij.Prefs.get", "ndef.noDenoise","false"))=="true");
var recordprogress = (toLowerCase(call("ij.Prefs.get", "ndef.recordProcess","false"))=="true");
var doInvert = (toLowerCase(call("ij.Prefs.get", "ndef.invertImages","false"))=="true");

/*
 * Default values
 */
rollingBallRadiusNanoDefineDefault = getWidth()*15/100;	//15% of image width

minSizeNanoDefineDefault = 0;

minFeretNanoDefineDefault = 10;

filterSolidityDefault = 0;

filterConvexityDefault=0;

objectIntensityThresholdDefault = 16;

localThresholdWindowSizeNanoDefineDefault = getWidth() * 15/1024 // 15 was a goodl value for images with a width of 1024px (= ~ 1.5% of the image width)

shapeSmoothingNumberFD = 6;

/*
 * Development variables
 */
var testmode = false;
var chatty = false;
var backgroundSubstractedImageTitle = "";	

macro "HAADF" {
	run("Options...", "iterations=1 count=1 black edm=Overwrite do=Nothing"); //Set black background!
	run("Is global calibration");
	var isGlobal = (toLowerCase(call("ij.Prefs.get", "ndef.cal.global","false"))=="true");

	/*
	 * Check if default values should be used and replace the current value with the current defaul value.
	 */
	segLocalRBR = checkGetNanoDefineDefault(segLocalRBR,rollingBallRadiusNanoDefineDefault);
	filterMinSize = checkGetNanoDefineDefault(filterMinSize,minSizeNanoDefineDefault);
	filterMinFeretMin = checkGetNanoDefineDefault(filterMinFeretMin,minFeretNanoDefineDefault);
	filterSolidity = checkGetNanoDefineDefault(filterSolidity,filterSolidityDefault);
	filterConvexity = checkGetNanoDefineDefault(filterConvexity,filterConvexityDefault);
	objectIntensityThreshold = checkGetNanoDefineDefault(objectIntensityThreshold,objectIntensityThresholdDefault);
	localThresholdWindowSize = checkGetNanoDefineDefault(localThresholdWindowSize,localThresholdWindowSizeNanoDefineDefault);
	imagepath = getDirectory("image")+getTitle();

	/*
	 * Save used parameters for other plugins.
	 */
	call("ij.Prefs.set", "ndef.used.rollingBallRadius",toString(segLocalRBR)); 
	call("ij.Prefs.set", "ndef.used.minSize",toString(filterMinSize)); 
	call("ij.Prefs.set", "ndef.used.minFeretMin",toString(filterMinFeretMin)); 
	call("ij.Prefs.set", "ndef.used.filterSolidity",toString(filterSolidity)); 
	call("ij.Prefs.set", "ndef.used.convexity",toString(filterConvexity)); 
	call("ij.Prefs.set", "ndef.used.objectIntensityThreshold",toString(objectIntensityThreshold)); 
	call("ij.Prefs.set", "ndef.used.localThresholdWindowSize",toString(localThresholdWindowSize)); 
	call("ij.Prefs.set", "ndef.used.smoothingFactor",toString(smoothingFactor)); 
	call("ij.Prefs.set", "ndef.used.path",imagepath); 
	
	debuglog("Analyzed Image: " + imagepath); 
	debuglog("Rolling Ball Radius:" + segLocalRBR);
	debuglog("Min Area:" + filterMinSize);
	debuglog("Min Feret Min:" + filterMinFeretMin);
	debuglog("Solidity:" + filterSolidity);
	debuglog("Convexity:" + filterConvexity);
	debuglog("Int. Thresh.:" + objectIntensityThreshold);
	debuglog("Local Thresh Window Size:" + localThresholdWindowSize);
	debuglog("Do selection: " + doSelectRegion);
	debuglog("Do irr watershed: " + doIrregularWatershed);
	debuglog("Irr watershed convexity threshold: " + irregularWatershedConvexityThreshold);
	/*
	 * Add text to imagej log if chatty is true
	 */
	function debuglog(text){
		if(chatty){
		IJ.log(text);
		}
	}

	/*
	 * If value is -1, use the default value.
	 */
	function checkGetNanoDefineDefault(value,NanoDefineDefaultValue){
		if(value==-1){
		  return(NanoDefineDefaultValue);
		}
		return(value)
	}
	 
	 // -2 = No restriction
	 function shapefilter(area,areaConvex,solidity,convexity,aspectRatio,minferet, disableScale,fillResultsTable){
	
		if(area==-2){
			area = 0;
		}
		if(areaConvex==-2){
			areaConvex=0;
		}
		if(solidity==-2){
			solidity=0;
		}
		if(convexity==-2){
			convexity=0;
		}
		if(aspectRatio==-2){
			aspectRatio="Infinity";
		}
		if(minferet ==-2){
			minferet = 0;
		}
	
		getPixelSize(unit, pixelWidth, pixelHeight);
		if(disableScale==true){
			//Remove the scale because the settings are in pixels
			
			run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");
			w = getWidth();
			h = getHeight();
		}
		fillrt = "";
		if(fillResultsTable==true){
			fillrt = "fill_results_table ";
		}
		//Run the Shape Filter on current image
	


		debuglog("Call area " + area + " areaConvex " + areaConvex + " minferet " + minferet + " ar "  + aspectRatio + " convex + " + convexity + " solidity " + solidity + " fillrt " + fillrt);
		run("Shape Filter", "area="+area+"-Infinity area_convex_hull=" + areaConvex + "-Infinity perimeter=0-Infinity perimeter_convex_hull=0-Infinity feret_diameter=0-Infinity min._feret_diameter="+minferet+"-Infinity max_inscr_circle_diameter=0-Infinity long_side_min._bounding_rect.=0-Infinity short_side_min._bounding_rect.=0-Infinity aspect_ratio=1-"+aspectRatio+" area_to_perimeter_ratio=0-Infinity circularity=0-Infinity elongation=0-1 convexity="+convexity+"-1 solidity="+solidity+"-1 num._of_holes=0-Infinity thinnes_ratio=0-1 contour_temperatur=0-1 orientation=0-180 fractal_box_dimension=0-2 option->box-sizes=2,3,4,6,8,12,16,32,64 draw_holes black_background "+fillrt+" exclude_on_edges stack");

		if(disableScale==true){
			//Reset Scale the scale
			add = "";
			if(isGlobal){
				add = " global";
			}
			run("Set Scale...", "distance="+1/pixelWidth+" known=1 pixel=1 unit="+unit + "" + add);
		}
		
	 }

	 function addActiveImageToProcessStack(text){
		if(isOpen("process")){
			title = getTitle();
			run("Duplicate...", "title=addToProcess duplicate range=1-1");
			setFont("SansSerif", 20, "bold");
			setForegroundColor(200, 200, 200);
			drawString(text, 20, 20);
			selectWindow("process");
			run("Concatenate...", "  title=process image1=process image2=addToProcess image3=[-- None --]");
			selectWindow(title);
		}
		else{
			title = getTitle();
			run("Duplicate...", "title=process duplicate range=1-1");
			setFont("SansSerif", 20, "bold");
			setForegroundColor(200, 200, 200);
			drawString(text, 20, 20);
			selectWindow(title);
		}
	 }

	/*
	 * Apply the rolling ball algorithm
	 */
	 function applyRollingBall(){
		if(segLocalRBR==-1){
			segLocalRBR = rollingBallRadiusNanoDefineDefault;
		}
		debuglog("Call Subtract Background radius " + segLocalRBR);
		run("Subtract Background...", "rolling="+segLocalRBR+" sliding stack");
	 }

	/*
	 * Segmentation method
	 * 1. Apply a non local means filter
	 * 2. Subtract background
	 * 3. If the standard deviation of the noise is large, apply a small median filter
	 * 4. Apply the Phnsalker local segmentation method
	 */
	function LocalMethod() {
		showStatus("Denoising...");
		if(noDenoise==false){
			run("Non-local Means Denoising", "sigma=15 smoothing_factor="+smoothingFactor+" auto stack");
			stringsSigma = call("ij.Prefs.get", "nlmeans.sigma","15");
		
			debuglog("Call NL Means sigmas: " + stringsSigma);
			debuglog("smoothing factor " + smoothingFactor);
	
			if(recordprogress){addActiveImageToProcessStack("Non-Local-Means");}
		}
		showProgress(0.5);
	
		applyRollingBall();
		currentImageID = getImageID();
		run("Duplicate...", "title=backgroundSubstractedImage duplicate range=1-"+ nSlices);
		backgroundSubstractedImageTitle = getTitle();
		if(recordprogress){addActiveImageToProcessStack("Background substracted");}
		if(noDenoise==false){
			stringsSigmaSplitted = split(stringsSigma,",");
			sigmas = newArray(stringsSigmaSplitted.length);
			for (i=0; i< stringsSigmaSplitted.length; i++){
		      sig=parseInt(stringsSigmaSplitted[i]);
			  if(sig>10){
				//If the noise is high...
				setSlice(i+1);
				debuglog("Call Median radius 2 slice: " + i+1);
				run("Median...", "radius=2 slice");
				if(recordprogress){addActiveImageToProcessStack("Median");}
		      }
			}
		}
		
		run("Duplicate...", "title=copy duplicate range=1-"+ nSlices);
		setBatchMode("hide");

		if(localThresholdWindowSize==-1){
			localThresholdWindowSize = localThresholdWindowSizeNanoDefineDefault;
		}
		debuglog("Call Local Thresh, Window Size:" + localThresholdWindowSize);
		run("Auto Local Threshold", "method=Phansalkar radius="+localThresholdWindowSize+" parameter_1=0 parameter_2=0 white stack");
		if(recordprogress){addActiveImageToProcessStack("Thresholded");}
		rename("Segmentierung");

		showProgress(0.7);

	}

	function applyWatershed() {
		if(singeParticleMode==false){
			if(doIrregularWatershed){
				//run("Irregular Watershed", "erosion="+irregularWatershedErosionNumber+" stack");
				run("Irregular Watershed", "erosion=1 convexity_threshsold="+irregularWatershedConvexityThreshold+" stack");
				if(recordprogress){addActiveImageToProcessStack("Irregular Watershed");}
			}
			else{
				run("Watershed", "stack");
				if(recordprogress){addActiveImageToProcessStack("Watershed");}
			}
		}
		
		
	}

	function classicalWatershedApproach() {
		
	}

	run("Remove Overlay");
	eval("script","IJ.getInstance().setAlwaysOnTop(false);");
	//eval("script","IJ.getInstance().setAutoRequestFocus(false);");
        
	/*
	 * Choose Region of Interest
	 */
	run("Select None");
	setTool("rectangle");
	if(doSelectRegion==true){
		waitForUser("Rectangular selection","Please select an rectangular region and press OK. If no selection is done, the whole image will be used.");
		if (selectionType() != 0)        {                    //make sure we have got a rectangular selection 
			run("Select All"); //exit("Sorry, no rectangle");
		}
	}else{
		run("Select All");
	}
	
	showProgress(0.05);

	/*
	 * Crop image to the selected roi
	 */
	getSelectionBounds(xroi,yroi,wroi,hroi);
	makeRectangle(xroi, yroi, wroi, hroi);
	run("Crop");

	/*
	 * Duplicate the original image and work with a duplicate
	 */
	setBatchMode("true");

	originaltitle = getTitle();
	orgImageID = getImageID();

	run("Duplicate...", "duplicate");
	setBatchMode("hide");
	if(doInvert==true){
		run("Invert", "stack");	
	}
	workingtitle = getTitle();
	workid = getImageID();
	selectImage(workid);
	run("8-bit");
//	getLocationAndSize(wX, wY, wWidth, wHeight);
	//setBatchMode("hide");

	if(recordprogress){addActiveImageToProcessStack("Input");}
	//call("ij.gui.ImageWindow.setNextLocation", wX, wY); // Show the new Window
														// at the same position
														// as the orignal window
	//run("Duplicate...", "duplicate");

	//originaltitle = getTitle();
	//orgImageID = getImageID();
	
	//selectImage(workid);


	showProgress(0.1);

	/*
	 * Do segmentation
 	*/
	LocalMethod();
	segImgID = getImageID();
	run("Duplicate...", "title=BeforeWatershed duplicate range=1-"+ nSlices);
	beforeWatershedID = getImageID();
	selectImage(segImgID);
	debuglog("Call Watershed");
	applyWatershed();
	run("Duplicate...", "title=AfterWatershed duplicate range=1-"+ nSlices);
	selectImage(segImgID);
	

	showProgress(0.75);

	/*	
	 * 	Remove objects by shape
	 */
	shapefilter(filterMinSize,-2,filterSolidity,filterConvexity,-2,filterMinFeretMin,true,false);
	if(recordprogress){addActiveImageToProcessStack("Shape Filtered");}

	/*
	 * SPECIAL CASE: WHEN WATERSHED AND SPM IS ACTIVATED
     */
	if(singeParticleMode==true){
			if(doIrregularWatershed){
				run("Irregular Watershed", "erosion=1 convexity_threshsold="+irregularWatershedConvexityThreshold+" stack");
				if(recordprogress){addActiveImageToProcessStack("Watershed");}
			}
	}

	/*
	 * Remove blobs with a intensity lower than the object intensity threshold
	 */
	selectImage(segImgID);
	if(objectIntensityThreshold==-1){
		objectIntensityThreshold=objectIntensityThresholdDefault;
	}
	//backgroundSubstractedImageTitle
	debuglog("Remove blobs with lower median density of "+ objectIntensityThreshold);
	run("Remove Blobs", "greyscale="+backgroundSubstractedImageTitle+" mean=0 median="+objectIntensityThreshold+" stack");
	close(backgroundSubstractedImageTitle);
	if(recordprogress){addActiveImageToProcessStack("Intensity filtered");}
	showProgress(0.8);

	if(ellipseFittingMode == 0){
		close("AfterWatershed"); //Only needed for Ellipse Fitting
		/*
		 * Smooth object contours
		 */
		if(doIrregularWatershed){
			shapeSmoothingNumberFD = 12;
		}
		//run("Shape Smoothing", "relative_proportion_fds=9 absolute_number_fds=2 keep=[Relative_proportion of FDs] black stack");
		run("Shape Smoothing", "relative_proportion_fds=2 absolute_number_fds=6 keep=[Relative_proportion of FDs] use black stack");
		//run("Shape Smoothing", "relative=6 absolute="+shapeSmoothingNumberFD+" keep=[Absolute number of FDs] black stack");
		if(recordprogress){addActiveImageToProcessStack("Shape smoothing");}

		/*
		 * Apply Watershed again. Reason: The shape smoothing results sometimes in reconnected components.
		 */
		applyWatershed();

		/*
	 * SPECIAL CASE: WHEN WATERSHED AND SPM IS ACTIVATED
     */
	   if(singeParticleMode==true){
		if(doIrregularWatershed){
			run("Irregular Watershed", "erosion=1 convexity_threshsold="+irregularWatershedConvexityThreshold+" stack");
			if(recordprogress){addActiveImageToProcessStack("Watershed");}
		}
	   }




		selectImage(workid);
		run("Close");
		run("Select None");
		selectImage(segImgID);
		showProgress(0.9);

		/*	
		 * 	Estimate features
		 */
		shapefilter(-2,-2,-2,-2,-2,-2,false,true);
		if(recordprogress){addActiveImageToProcessStack("Shape Filter #2");}
		if(nResults==0){
			exit("No particles could be detected")	
		}
		call("ij.Prefs.set", "ndef.NumberOfParticles",toString(nResults)); 
		/*
		 * Show results as overlay
		 */
		run("Show Blobs as overlay", "binary_image=Segmentierung target_image=["+originaltitle+"]");
		if(binaryMode==false) {
		 	selectImage(segImgID);
		 	run("Close"); 
		}

		selectImage(orgImageID);
		//setBatchMode("show");
		selectImage(beforeWatershedID);
		//setBatchMode("show");
		
		showProgress(0.95);
		
		

		/*
		 * Register image to shape filter plugins. This enabales the selection of particles by mouse 
		 */
		run("Register Image to ShapeFilter", "image=["+originaltitle+"]");
		
		/*
		 * Enables the selection and analysis of agglomerates 
		 */
		run("Agglomerate Manager", "agglomerated=BeforeWatershed deagglomerated=["+originaltitle+"] agglomerated_black_background");

		/*
		 * Replaces the "Distribution" function in the results table menu by a nanodefine specific function.
		 */
		run("Replace Distribution in Results Table");
		
		
		selectImage(orgImageID);
		run("Select None");      
		showProgress(1);
		
		
		setBatchMode("false");
	
		/*
		 * Show histogram
		 */
		getPixelSize(unit, pixelWidth, pixelHeight); 
		//call("ij.gui.ImageWindow.setNextLocation", wX, wY); // Show the new Window
														// at the same position
														// as the orignal window
		if(noPlot==false){
		 run("R Histogram", "data_column=[Min. Feret] title=[Distribution of Min. Feret Diameter] x-axis_label=[Diameter ("+unit+")] y-axis_label=[Frequency] fit=[None] show");
		 rename("Size Distribution for "+ originaltitle);
		 histID = getImageID();
		}

		if(noPlot==false){call("ij.Prefs.set", "ndef.result.histid",toString(histID));}
		call("ij.Prefs.set", "ndef.result.imagewithoverlayid",toString(orgImageID));
		if(binaryMode){call("ij.Prefs.set", "ndef.result.binaryid",toString(segImgID)); } 
		run("Export CMF");
	}
	else{
		selectImage(workid);
		run("Close");
		
		selectImage(orgImageID);
		//setBatchMode("show");
		
		//setBatchMode("show");
		selectImage(segImgID);
		binary=getTitle();
		selectImage(beforeWatershedID);


		run("Ellipse Split", "binary="+binary+" add_to_results_table merge_when_relativ_overlap_larger_than_threshold overlap=92 major="+filterEllipseMinLongLength+"-Infinity minor="+filterEllipseMinShortLength+"-Infinity aspect=1-"+filterEllipseMaxAspectRatio+" stack");
		
		if(nResults==0){
			exit("No particles could be detected")	
		}
		call("ij.Prefs.set", "ndef.NumberOfParticles",toString(nResults)); 
		close("AfterWatershed");
		selectImage(orgImageID);

		run("Show Ellipses as overlay", "binary_image=Segmentierung target_image=["+originaltitle+"]");
		if(binaryMode==false) {
		 	selectImage(segImgID);
		 	run("Close"); 
		}
		close("BeforeWatershed");
		setBatchMode("false");

		if(noPlot==false){
		 run("R Histogram", "data_column=[Length short axis] title=[Distribution of short axis length] x-axis_label=[Length short axis] y-axis_label=Frequency fit=None show");
		 histID = getImageID();
		}
	
		/*
		 * Register image to ellipse split plugins. This enables the selection of particles by mouse 
		 */
		run("Register Image to EllipseSplit", "image=["+originaltitle+"]");

		/*
		 * Replaces the "Distribution" function in the results table menu by a nanodefine specific function.
		 */
		run("Replace Distribution in Results Table");
		selectImage(orgImageID);
		//rename(workingtitle);
		run("Select None");
	//	run("Tile");       
		showProgress(1);
		if(noPlot==false){call("ij.Prefs.set", "ndef.result.histid",toString(histID));}
		call("ij.Prefs.set", "ndef.result.imagewithoverlayid",toString(orgImageID));
		if(binaryMode){call("ij.Prefs.set", "ndef.result.binaryid",toString(segImgID)); } 
		run("Export CMF");
	}
	

}
