"""
test_lognormal_distribution.py

Simulate the particles from a lognormal distribution, saving
the results in a .csv file. This is a proof-of-concept script.
The long term goal is to generate images with circular particles
with a lognormal distribution for particle size analysis. Here I
used functions from org.apache.commons.math3 to generate the diameters.
These are written to a .csv file

Date        Who  What
----------  ---  -------------------------------------------------------
2019-06-18  JRM  Used the org.apache.commons.math3 functions Log
                 and LogNormalDistribution to generate the particles
                 and save the equilen circular diameter to a .csv 
                 file. This included writing the
                 gen_random_lognormal_particle function and figuring
                 out how to write a custom results table.

"""
from org.apache.commons.math3.distribution import LogNormalDistribution
from org.apache.commons.math3.analysis.function import Log
from ij.measure import ResultsTable
from ij import IJ
import time
import os

git_home = os.getenv("GIT_HOME")
print(git_home)

csv_out = git_home + "/tips/ImageJ/csv/test_gen_lognormal_particles.csv"

"""
distn = LogNormalDistribution(3.912023, 0.1823216)
my_sample = distn.sample()
print(my_sample)

my_ln = Log()

my_gmd = Log().value(50.0)
my_gsd = Log().value(1.2)

print(my_gmd, my_gsd)


print(my_ln.value(50.0))
"""

def gen_random_lognormal_particle(gmd_nm, gsd):
	"""
	gen_random_lognormal_particle(gmd_nm, gsd)

	Generate a random particle from a lognormal distribution
	given the geometric mean diameter in nm and the geometric
	standard deviation.

	Parameters
	----------
	gmd_nm	double
			The geometric mean diameter for the distribution in
			nm. Example: 50.0
	gsd		double
			The geometric standard deviation of the lognormal 
			distribution (dimensionless). Example: 1.2

	Returns
	-------
	the_sample	double
				The random sample from the distribution
	"""
	my_gmd = Log().value(gmd_nm)
	my_gsd = Log().value(gsd)
	distn = LogNormalDistribution(my_gmd, my_gsd)
	the_sample = distn.sample()
	return(the_sample)

tic = time.time()

n_samples = 2500
rt = ResultsTable(n_samples)
rt.setHeading(0, "num")
rt.setHeading(1, "ECD nm")

for x in range(0, n_samples):
	my_sample = gen_random_lognormal_particle(50.0, 1.2)
	rt.setValue(0, x, x+1)
	rt.setValue(1, x, my_sample)


rt.show("Results")
IJ.saveAs("Results", csv_out)

toc = time.time()
elapsed = toc - tic
print("generated %g particles" % n_samples)
print("completed in %g sec" % elapsed )
print("saved here:")
print("%s" % csv_out )
print("done...")
rt.reset()
