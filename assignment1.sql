CREATE TABLE Employee (
	emp_no int auto_increment primary key,
	emp_name varchar(255) not null,
	emp_join_date date default SYSDATE,
	emp_status char(1) CHECK (emp_status IN ('P', 'C', 'R'))
);

CREATE TABLE Project (
	project_code varchar(255) primary key,
	project_desc varchar(255) unique not null,
	project_start_date date not null,
	project_end_date date
);

CREATE TABLE Project_Allocation (
	project_code varchar(255) not null,
	emp_no int not null,
	emp_proj_alloc_date date,
	emp_proj_release_date date,
	foreign key (emp_no) references Employee(emp_no),
	foreign key (project_code) references Project(project_code)
);

INSERT INTO Employee VALUES (101, 'Jhonny', TO_DATE('2005-07-01','YYYY-MM-DD'), 'C');
INSERT INTO Employee VALUES (116, 'Nayak', TO_DATE('2005-08-16','YYYY-MM-DD'), 'C');
INSERT INTO Employee VALUES (202, 'Meera', TO_DATE('2006-01-30','YYYY-MM-DD'), 'C');
INSERT INTO Employee VALUES (205, 'Ravi', TO_DATE('2006-02-11','YYYY-MM-DD'), 'C');
INSERT INTO Employee VALUES (304, 'Hari', TO_DATE('2006-11-25','YYYY-MM-DD'), 'P');
INSERT INTO Employee VALUES (307, 'Nancy', TO_DATE('2007-01-15','YYYY-MM-DD'), 'P');
INSERT INTO Employee VALUES (403, 'Nick', TO_DATE('2007-01-21','YYYY-MM-DD'), 'P');

INSERT INTO Project VALUES ('P001', 'Environment Pollution', TO_DATE('2005-08-02', 'YYYY-MM-DD'), TO_DATE('2006-12-11', 'YYYY-MM-DD'));
INSERT INTO Project VALUES ('P002', 'Learning Curve', TO_DATE('2006-02-01', 'YYYY-MM-DD'), null);
INSERT INTO Project VALUES ('P003', 'Effects of IT', TO_DATE('2007-01-03', 'YYYY-MM-DD'), null);

INSERT INTO Project_Allocation VALUES ('P001', 101, TO_DATE('2005-08-01', 'YYYY-MM-DD'), TO_DATE('2006-12-11', 'YYYY-MM-DD'));
INSERT INTO Project_Allocation VALUES ('P001', 116, TO_DATE('2005-08-16', 'YYYY-MM-DD'), TO_DATE('2006-12-11', 'YYYY-MM-DD'));
INSERT INTO Project_Allocation VALUES ('P002', 202, TO_DATE('2006-02-01', 'YYYY-MM-DD'), TO_DATE('2007-01-14', 'YYYY-MM-DD'));
INSERT INTO Project_Allocation VALUES ('P002', 307, TO_DATE('2007-01-15', 'YYYY-MM-DD'), null);
INSERT INTO Project_Allocation VALUES ('P002', 205, TO_DATE('2006-02-11', 'YYYY-MM-DD'), null);
INSERT INTO Project_Allocation VALUES ('P003', 403, TO_DATE('2007-01-21', 'YYYY-MM-DD'), null);
INSERT INTO Project_Allocation VALUES ('P003', 304, TO_DATE('2007-01-03', 'YYYY-MM-DD'), null);
INSERT INTO Project_Allocation VALUES ('P003', 101, TO_DATE('2007-01-03', 'YYYY-MM-DD'), null);
INSERT INTO Project_Allocation VALUES ('P003', 116, TO_DATE('2007-01-03', 'YYYY-MM-DD'), null);
INSERT INTO Project_Allocation VALUES ('P003', 202, TO_DATE('2007-01-15', 'YYYY-MM-DD'), null);

SELECT * FROM Project;
SELECT * FROM Employee;
SELECT * FROM Employee WHERE emp_status = 'C';
SELECT * FROM Employee WHERE emp_join_date > TO_DATE('2006-11-01', 'YYYY-MM-DD');
SELECT * FROM Project WHERE project_start_date > TO_DATE('2006-01-01', 'YYYY-MM-DD');
SELECT * FROM Project_Allocation INNER JOIN Employee ON Project_Allocation.emp_no = Employee.emp_no WHERE Project_Allocation.project_code = 'P003';
SELECT * FROM Project where project_end_date is null;
SELECT * FROM Project_Allocation INNER JOIN Employee ON Project_Allocation.emp_no = Employee.emp_no WHERE Project_Allocation.project_code = 'P002' AND emp_proj_release_date is not null;
SELECT (project_end_date - project_start_date) as days FROM Project WHERE project_code = 'P001';
SELECT SUM(NVL(emp_proj_release_date, TRUNC(SYSDATE)) - emp_proj_alloc_date) FROM Project_Allocation;
SELECT SUM(NVL(emp_proj_release_date, TRUNC(SYSDATE)) - emp_proj_alloc_date) FROM Project_Allocation GROUP BY project_code;

ALTER TABLE Project ADD Manager int;
ALTER TABLE Project ADD CONSTRAINT manager_fk
    FOREIGN KEY (Manager) REFERENCES EMPLOYEE(EMP_NO);
	
UPDATE Project SET Manager = 101 WHERE project_code = 'P001';
UPDATE Project SET Manager = 202 WHERE project_code = 'P002';
UPDATE Project SET Manager = 116 WHERE project_code = 'P003';

INSERT INTO Project VALUES ('P004', 'Election Rage', TO_DATE('2007-03-01', 'YYYY-MM-DD'), null);
DELETE FROM Project WHERE project_desc = 'Election Rage'