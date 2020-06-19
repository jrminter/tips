---
title: "ImageJ Plugin Development"
author: "J. R. Minter"
date: "Started: 2020-06-19, Last modified: 2020-06-19"
output:
  html_document:
    keep_md: yes
    css: ../theme/jm-gray-vignette.css
    number_sections: yes
    toc: yes
    toc_depth: 3
---

[Back to ImageJ](ImageJ.html)


# Introduction

This started wit a nice example on plugin development
by Carl Phillipe.

> I don't know whether what I will be describing below is "the
> recommended method", nevertheless so far it was always working for me.

> 1. Thus in the case I wan't to modify a plugin or package packed within 
> a .jar file, I close ImageJ, move the .jar file out from the plugins
> folder (or subfolder within the plugins folder) into the ImageJ root
> folder (i.e. the one where there is the ImageJ.exe file).
>
> By doing so ImageJ won't anymore be able to detect the .jar file as in
> the same time I don't move the .jar too far away from where I will soon
> need it again.
> 
> Then I unpack the .jar content into a dedicated folder within the plugins
> folder and work on the code from there, i.e. modify the code and 
> Compile&run it until I'm happy with the obtained version.
>
> Once done I close again ImageJ, overwrite the old .java and .class
> files with the .jar file I had put in the ImageJ root folder by the
> new obtained one, move the .jar file back into the plugins folder and
> either erase the folder I worked in (or move it to the ImageJ root
> folder in the case I think that I may probably soon modify again the code).
>
> 2. I also saw that if you want to access to classes packed within other
> .jar (than the one you are working on) you should rather put these .jar
> files within the plugins/jars folder to be able to access them (which
> is probably the answer to your described issue).
>
> I hope this helps you to move forward.
> My best regards,
> Philippe
> 
> Philippe CARL
> Laboratoire de Bioimagerie et Pathologies
> UMR 7021 CNRS - Université de Strasbourg
> Faculté de Pharmacie
> 74 route du Rhin
> 67401 ILLKIRCH
> Tel : +33(0)3 68 85 42 89

----- Mail original -----
De: "Fred Damen" <fred@DAMEN.ORG>
À: "imagej" <IMAGEJ@LIST.NIH.GOV>
Envoyé: Jeudi 18 Juin 2020 22:33:48
Objet: Compiling, directories, and jar files rules

Greetings,

I am seeing what seems strange when using "Compile and Run" regarding
class names and JAR file names.  I am trying to compile a Java plugin that
uses a class for a plugin (Gnu_Plot) that I placed in a subdirectory
(Gnu_Plot) of plugins and created a jar file (Gnu_Plot.jar) for this
plugin, following https://imagej.nih.gov/ij/plugins/jar-demo.html. Running
Gnu_Plot from the menus works fine.  Trying to compile another plugin that
calls Gnu_plot methods does not know of the existence of Gnu_Plot, Even
though the java source and class files exist in the subdirectory and jar
file. Renaming the jar file to GnuPlot.jar, with and without restarting
ImageJ, the "Compile and Run" now finds Gnu_Plot and this plugin compiles
fine.

a) In the case that I described above, where is "Compile and Run" supposed
to find the class files, from within the jar file, from within
subdirectories? search order?
b) Is there a specific place that the class files need to be within the
jar file for them to be found during compiling?

Thanks in advance,

Fred



[Back to ImageJ](ImageJ.html)
