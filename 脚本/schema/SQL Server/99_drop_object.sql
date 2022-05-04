ALTER TABLE employees DROP CONSTRAINT emp_dept_fk;
ALTER TABLE employees DROP CONSTRAINT emp_job_fk;
ALTER TABLE employees DROP CONSTRAINT emp_manager_fk;
DROP TABLE departments;
DROP TABLE jobs;
DROP TABLE employees;

