importClass(Packages.ij.IJ);
importClass(Packages.ij.ImagePlus);
importClass(Packages.ij.VirtualStack);
importClass(java.io.File);

dir = IJ.getDir("Choose Directory ");
f = new File(dir);
list = f.list();
stack = new VirtualStack(256, 256, null, dir);
for (i=0; i<list.length; i++) {
     if (list[i].endsWith(".tif"))
        stack.addSlice(list[i]);
}
img = new ImagePlus("Virtual Stack", stack);