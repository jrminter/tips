import os
import csv

git_home = os.getenv("GIT_HOME")
print(git_home)

csv_path = git_home + "/tips/ImageJ/csv/test_gen_lognormal_particles.csv"

the_csv = csv.reader(open(csv_path), delimiter=',', quotechar='|')
for row in the_csv:
	print (', '.join(row))