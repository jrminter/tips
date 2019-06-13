@String(label="Image Directory", style="") img_dir
@String(label="Image Base Name", style="") img_name
import ij.IJ
import ij.WindowManager
import java.lang.*
import ij.plugin.Duplicator

// Start Clean
// 1) close all images
IJ.run("Close All")
// 2) clear the log
IJ.log("\\Clear")

imp_in = IJ.openImage(img_dir + "/" + img_name + ".tif");
imp_in.show()

imp_wrk = imp_in.duplicate()
imp_wrk.setTitle("jpg")

// save the image as jpg
img_out = img_dir + "/" + img_name + ".jpg"
IJ.saveAs(imp_wrk, "jpg", img_out)

imp_wrk = IJ.openImage(img_out)
imp_wrk.show()

// convert to 32 bit prior to subtraction
IJ.run(imp_in, "32-bit", "")
IJ.run(imp_wrk, "32-bit", "")
imp_out = imp_in.duplicate()
IJ.run(imp_out, "Calculator Plus", "i1=mandrill_256.tif i2=mandrill_256.jpg operation=[Subtract: i2 = (i1-i2) x k1 + k2] k1=1 k2=0 create");
imp_cor = WindowManager.getImage("Result")
IJ.run(imp_cor, "Enhance Contrast", "saturated=0.35")
IJ.run(imp_cor, "mpl-viridis", "");
imp_out.close()
imp_cor.show()



