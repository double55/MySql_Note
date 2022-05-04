CREATE TABLE departments
    ( department_id    INTEGER NOT NULL
    , department_name  CHARACTER VARYING(30) NOT NULL
    , manager_id       INTEGER
    , location_id      INTEGER
	, CONSTRAINT dept_id_pk
                PRIMARY KEY (department_id)
    ) ;


CREATE TABLE jobs
    ( job_id         CHARACTER VARYING(10) NOT NULL
    , job_title      CHARACTER VARYING(35) NOT NULL
    , min_salary     INTEGER
    , max_salary     INTEGER
	, CONSTRAINT job_id_pk
               PRIMARY KEY(job_id)
    ) ;


CREATE TABLE employees
    ( employee_id    INTEGER NOT NULL
    , first_name     CHARACTER VARYING(20)
    , last_name      CHARACTER VARYING(25) NOT NULL
    , email          CHARACTER VARYING(25) NOT NULL
    , phone_number   CHARACTER VARYING(20)
    , hire_date      DATE NOT NULL
    , job_id         CHARACTER VARYING(10) NOT NULL
    , salary         NUMERIC(8,2)
    , commission_pct NUMERIC(2,2)
    , manager_id     INTEGER
    , department_id  INTEGER
	, CONSTRAINT     emp_emp_id_pk
                     PRIMARY KEY (employee_id)
    , CONSTRAINT     emp_salary_min
                     CHECK (salary > 0) 
    , CONSTRAINT     emp_email_uk
                     UNIQUE (email)
	, CONSTRAINT     emp_dept_fk
                     FOREIGN KEY (department_id)
                      REFERENCES departments(department_id)
    , CONSTRAINT     emp_job_fk
                     FOREIGN KEY (job_id)
                      REFERENCES jobs(job_id)
    , CONSTRAINT     emp_manager_fk
                     FOREIGN KEY (manager_id)
                      REFERENCES employees(employee_id)
    ) ;

