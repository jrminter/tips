// Open Leaf sample
run("Leaf (36K)");
 
// start plugin
run("Trainable Weka Segmentation");
 
// wait for the plugin to load
wait(3000);
selectWindow("Trainable Weka Segmentation v3.2.33");
 
// add one region of interest to each class
makeRectangle(367, 0, 26, 94);
call("trainableSegmentation.Weka_Segmentation.addTrace", "0", "1");
makeRectangle(186, 132, 23, 166);
call("trainableSegmentation.Weka_Segmentation.addTrace", "1", "1");
 
// enable some extra features
call("trainableSegmentation.Weka_Segmentation.setFeature", "Variance=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Mean=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Minimum=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Maximum=true");
call("trainableSegmentation.Weka_Segmentation.setFeature", "Median=true");
 
// change class names
call("trainableSegmentation.Weka_Segmentation.changeClassName", "0", "background");
call("trainableSegmentation.Weka_Segmentation.changeClassName", "1", "leaf");
 
// balance class distributions
call("trainableSegmentation.Weka_Segmentation.setClassBalance", "true");
 
// train current classifier
call("trainableSegmentation.Weka_Segmentation.trainClassifier");
 
// display probability maps
call("trainableSegmentation.Weka_Segmentation.getProbability");