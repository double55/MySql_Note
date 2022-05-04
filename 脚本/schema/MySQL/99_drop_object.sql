ALTER TABLE employees DROP FOREIGN KEY emp_dept_fk;
ALTER TABLE employees DROP FOREIGN KEY emp_job_fk;
ALTER TABLE employees DROP FOREIGN KEY emp_manager_fk;
DROP TABLE departments;
DROP TABLE jobs;
DROP TABLE employees;

