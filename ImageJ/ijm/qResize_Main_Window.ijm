// Script by Curtis Reuden to resize the window at startup
// 2019-05-31
// Place in macros/AutoRun
eval("js","IJ.getInstance().addWindowListener(new java.awt.event.WindowAdapter(){ windowOpened: function(e) { IJ.getInstance().setSize(800, IJ.getInstance().getSize().height); }});");