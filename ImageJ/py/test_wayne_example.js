/*

test_wayne_example.js

Wayne wrote (2019-07-25):

  The best way to create scripts that run quickly and reliably is
  to avoid displaying images and tables and to work with ImagePlus
  and ResultsTable objects. The particle analyzer will direct its
  output to a ResultsTable if you call
     ParticleAnalyzer.setResultsTable()
  and call
     ParticleAnalyzer.setSummaryTable()
  to have summary data directed to a ResultsTable
  (requires ImageJ 1.52p or later). The following example
  runs the particle analyzer separately on the three channels
  of the HelaCells sample image, with the output and summary
  data directed to ResultsTable objects, which are saved
  as CSV files.

*/

importClass(Packages.ij.IJ);
importClass(Packages.ij.measure.ResultsTable);
importClass(Packages.ij.plugin.filter.ParticleAnalyzer);

imp = IJ.openImage("http://wsr.imagej.net/images/hela-cells.zip");
imp.setDisplayMode(IJ.GRAYSCALE);
imp.show();
resultsTable = new ResultsTable();
summaryTable = new ResultsTable();
IJ.run("Set Measurements...", "area mean min centroid display");
for (c=1; c<=3; c++) {
	imp.setC(c);
	IJ.setAutoThreshold(imp, "Default dark");
	ParticleAnalyzer.setResultsTable(resultsTable);
	ParticleAnalyzer.setSummaryTable(summaryTable);
	IJ.run(imp, "Analyze Particles...", "size=5 display summarize clear slice");
}
dir = IJ.getDir("home") + "Downloads/" ;
resultsTable.save(dir + "Results.csv");
summaryTable.save(dir + "Summary.csv");
