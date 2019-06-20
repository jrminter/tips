"""

From here:
https://forum.image.sc/t/python-how-to-append-data-into-results-table/26673

"""

from ij import IJ
from ij import WindowManager
from ij.text import TextWindow
from ij.measure import ResultsTable
import math

# Set thickness of the optical section in a stack
z_thick = 4

IJ.run("Measure")

rt = ResultsTable.getResultsTable() 
    
x_col = rt.getColumnAsDoubles(rt.getColumnIndex('X'))
y_col = rt.getColumnAsDoubles(rt.getColumnIndex('Y'))
z_col = rt.getColumnAsDoubles(rt.getColumnIndex('Slice'))

br_uncorr = math.sqrt((x_col[1] - x_col[0])**2 + (y_col[1] - y_col[0])**2)
br_thick = (z_col[1] - z_col[0]) * z_thick
br_corr = math.sqrt(br_uncorr**2 + br_thick**2)

po_uncorr = math.sqrt((x_col[2] - x_col[1])**2 + (y_col[2] - y_col[1])**2)
po_thick = (z_col[2] - z_col[1]) * z_thick
po_corr = math.sqrt(po_uncorr**2 + po_thick**2)

mbl = math.sqrt((x_col[4] - x_col[3])**2 + (y_col[4] - y_col[3])**2)

sl = math.sqrt((x_col[6] - x_col[5])**2 + (y_col[6] - y_col[5])**2)
sw = math.sqrt((x_col[8] - x_col[7])**2 + (y_col[8] - y_col[7])**2)

IJ.run("Clear Results")

# Append to custom Measurement table or create it if non existing
MeasureTable = WindowManager.getWindow("Measurements")
if MeasureTable == None:
    MeasureTable = ResultsTable()
else:
	MeasureTable = WindowManager.getWindow("Measurements")
	MeasureTable = MeasureTable.getTextPanel().getOrCreateResultsTable()

MeasureTable.incrementCounter()
MeasureTable.addValue("BR", br_corr)
MeasureTable.addValue("PO", po_corr)
MeasureTable.addValue("MBL", mbl)
MeasureTable.addValue("SL", sl)
MeasureTable.addValue("SW", sw)
MeasureTable.show("Measurements")