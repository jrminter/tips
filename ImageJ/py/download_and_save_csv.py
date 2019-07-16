"""
download_and_save_csv.py

From:
http://wiki.cmci.info/documents/120206pyip_cooking/python_imagej_cookbook

"""

from ij import IJ
from java.io import PrintWriter
content = IJ.openUrlAsString('http://cmci.info/imgdata/tenFrameResults.csv')
out = PrintWriter('/Users/jrminter/tmp/test1.csv')
out.print(content)
out.close()