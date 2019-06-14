// defining a package named com.yoursite
package com.jrminter.jrmFijiGen

import ij.IJ
import ij.WindowManager
import java.lang.*
import ij.plugin.Duplicator

def close_open_non_image_window(str){
	arry = WindowManager.getNonImageTitles()
	if(arry.contains(str) == true){
		IJ.selectWindow(str)
		IJ.run("Close")
	}
}
