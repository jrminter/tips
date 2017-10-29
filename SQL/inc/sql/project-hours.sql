-- Display project names and hours for each experiment
-- sqlite3 experiments.db < project-hours.sql
-- The following line would be helpful with svn...
-- SELECT "$Id:$";
SELECT Project.ProjectName, Experiment.Hours
FROM Project JOIN Experiment
WHERE Project.ProjectId = Experiment.ProjectID;
