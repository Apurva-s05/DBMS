CREATE DATABASE emp;
USE emp;

CREATE TABLE employee(
   emp_id INT primary key,
   first_name VARCHAR(40) NOT NULL,
   last_name VARCHAR(40),
   birth_date DATE,
   sex VARCHAR(1) NOT NULL,
   super_id INT,
   salary INT,
   branch_id INT
);

CREATE TABLE branch(
     branch_id INT PRIMARY KEY,
     branch_name VARCHAR(40) NOT NULL,
     mgr_id INT NOT NULL,
     mgr_start_date DATE NOT NULL,
     FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client(
      client_id INT PRIMARY KEY,
      client_name VARCHAR(40),
      branch_id INT,
      FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with(
     emp_id INT,
     client_id INT,
	 total_sales INT,
	 PRIMARY KEY(emp_id, client_id),
     FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
	 FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier(
     branch_id INT,
     supplier_name VARCHAR(40),
     supply_type VARCHAR(40),
     PRIMARY KEY (branch_id,supplier_name),
     FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

INSERT INTO employee VALUES(100,'Apurva','Sarode','2021-07-13','F',250000,'NULL',1);
INSERT INTO branch VALUES(1,'Corporate',100,'2006-11-05');
UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101,'Gaurav','Patil','2019-05-13','M',50000,100,1);
INSERT INTO employee VALUES(102,'Shreya','Joshi','1997-11-02','F',7000,100,2);
INSERT branch VALUES(2,'Scranton',102,'1996-04-06');
UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103,'Mansi','Dugad','1980-06-02','F',47000,102,2);
INSERT INTO employee VALUES(104,'Kelly','Shah','2000-08-02','F',78000,102,2);
INSERT INTO employee VALUES(105,'Angelina','Martin','2001-04-11','F',9000,102,2);

-- Branch Supplier
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Custom');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');

-- Works_with
INSERT INTO works_with VALUES(105, 400, 500);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);

SELECT * FROM branch_supplier;