// The following JavaScript example opens a folder of images as a virtual stack. To get the width and height, it opens the last image in the folder. It does this because on macOS the first file may be ".DS_Store". An easier, but less flexible, way to open a folder of images is to use:
//    img = FolderOpener.open(dir,"virtual”).
//
//  -wayne

// win...
//  dir = “C:/Users/rasba/stack/";

// On mac this has issues with the .DStore file...
// mac
  importClass(Packages.ij.ImagePlus);
  importClass(Packages.ij.VirtualStack);
  importClass(Packages.java.io.File);
  importClass(Packages.ij.IJ);
  
  dir = "/Users/jrminter/Documents/git/tips/ImageJ/tif/for_stack/"; 
  f = new File(dir);
  list = f.list();
  n = list.length;
  print(n);
  img = IJ.openImage(dir+list[n-1]);
  stack = new VirtualStack(img.getWidth(),img.getHeight(),null,dir);
  for (i=0; i<n; i++)
     stack.addSlice(list[i]);
  img2 = new ImagePlus(""+dir,stack);
  img2.show();