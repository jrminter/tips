@String(label="CSV Directory", style="") csv_dir
@String(label="CSV Base Name", style="") csv_name

"""
load_csv_file

This is not terribly helpful. In reality, I'd postprocess
in R...

from:
http://wiki.cmci.info/documents/120206pyip_cooking/python_imagej_cookbook

"""

import csv

def readCSV(filepath):
	f = open(filepath, 'rb')
	data = csv.reader(f, delimiter=',')
	for row in data:
		# print(len(row))
		print ', '.join(row)
 
filepath = csv_dir + "/" + csv_name + '.csv'
readCSV(filepath)
