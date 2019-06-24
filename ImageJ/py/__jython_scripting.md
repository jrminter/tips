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


