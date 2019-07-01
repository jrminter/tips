# Jython Scripting Hints

Last edit: 2019-07-01

Started as a post to a user on the ImageJ Forum. A good list for me to keep up.

If you want to try `Jython`,  here are my favorite resources to help you get started:

- [Kota Miura's](http://wiki.cmci.info/documents/120206pyip_cooking/python_imagej_cookbook) cookbook

- [Albert Cardona's](https://www.ini.uzh.ch/~acardona/fiji-tutorial/) tutorial

- The [Jython Scripting](https://imagej.net/Jython_Scripting) page on `imagej.net`

- [Juan Nunez-Iglesias'](http://ilovesymposia.com/2014/02/26/fiji-jython/) tutorial

- The [ImageJ API](https://imagej.nih.gov/ij/developer/api/index.html) is essential to figure out the details of the ImageJ class structure to get the `import` statements and function calls right...

- [Script Parameters](https://imagej.net/Script_Parameters) are our friend! Note that there is an issue with the `@String` parameter. You want something like this: 
`@String(label="Image Directory", style="") img_dir`

- Set the macro recorder to `Javascript` or `Beanshell` to get a better representation. Note there are some calls that don't reproduce well so the examples in the resources above really help...

Hope this helps...

Best regards,
John Minter


# Some commands to remember

- `IJ.run("Measure")`
- `IJ.run("Clear Results")`
- `IJ.run(imp, "Line Width...", "line=60")`
- `from ij.plugin import ChannelSplitter`    
  `channels = ChannelSplitter.split(imp)`
- `MeasureTable = WindowManager.getWindow("Measurements")`
- `str_info = """Analyst: J. R. Minter
  Date Recorded: 2004-08-10 14:05
  Sample: Nalco silica
  Instrument: Philips CM20
  Conditions: CryoTEM 200 kV 38,000X LowDose
  Notes: Original image size 1024x1024x16 bits/px 
  Comment: 2019-06-19: Rotated and cropped in Fiji to get best particles. 
  """
  imp.setProperty("Info", str_info)`

- `import os`
  `git_home = os.getenv("GIT_HOME")`

- `from ij.plugin import ImageCalculator`
  `ic = ImageCalculator()`
  `imp_sub = ic.run("Subtract create 32-bit", imp_jpg, imp_ori)`

- `IJ.run(imp_ori, "32-bit", "")`
- `IJ.run(imp_sub, "Enhance Contrast", "saturated=0.35")`
- `IJ.run(imp_sub, "8-bit", "")`
- `from ij import WindowManager`
  `print(WindowManager.getImageTitles())`
  `img_cnt = WindowManager.getImageCount()`
- `from ij.plugin import ChannelSplitter`
  `channels = ChannelSplitter.split(imp_leaf)`
  `# red`
  `channels[0].show()`
  `# green`
  `channels[1].show()`
  `# blue`
  `channels[2].show()`

  `from ij.plugin.frame import RoiManager`
  `def add_roi_and_update(imp, rm, roi_num):`
      `rm.select(roi_num)`
      `rm.selectAndMakeVisible(imp, roi_num)` 
      `imp.updateAndRepaintWindow()`

   `roi_num = 0`
   `add_roi_and_update(channels[0], rm, roi_num)`








