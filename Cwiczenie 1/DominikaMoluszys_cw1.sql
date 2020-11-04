DROP TABLE JOBS CASCADE CONSTRAINTS;
DROP TABLE REGIONS CASCADE CONSTRAINTS;
DROP TABLE COUNTRIES CASCADE CONSTRAINTS;
DROP TABLE LOCATIONS CASCADE CONSTRAINTS;
DROP TABLE DEPARTMENTS CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEES CASCADE CONSTRAINTS;
DROP TABLE JOB_HISTORY CASCADE CONSTRAINTS;

CREATE TABLE JOBS(
    JOB_ID INT PRIMARY KEY, 
    JOB_TITLE VARCHAR(30) NOT NULL, 
    MIN_SALARY FLOAT(126) NOT NULL CHECK (('MAX_SALARY'-'MIN_SALARY')>=2000), 
    MAX_SALARY FLOAT(126) NOT NULL
    );

CREATE TABLE REGIONS(
    REGION_ID INT PRIMARY KEY, 
    REGION_NAME VARCHAR(100) NOT NULL
    );

CREATE TABLE COUNTRIES(
    COUNTRY_ID INT PRIMARY KEY, 
    COUNTRY_NAME VARCHAR(100) NOT NULL, 
    REGION_ID INT CONSTRAINT FK_REGIONS REFERENCES REGIONS(REGION_ID)
    );

CREATE TABLE LOCATIONS(
    LOCATION_ID INT PRIMARY KEY, 
    STREET_ADRESS VARCHAR(255) NOT NULL, 
    POSTIALITY_CODE VARCHAR(255) NOT NULL, 
    CITY VARCHAR(50) NOT NULL, 
    STATE_PROVINCE VARCHAR(100) NOT NULL, 
    COUNTRY_ID INT CONSTRAINT FK_COUNTRIES REFERENCES COUNTRIES(COUNTRY_ID)
    );

CREATE TABLE DEPARTMENTS(
    DEPARTMENT_ID INT PRIMARY KEY, 
    DEPARTMENT_NAME VARCHAR(100) NOT NULL, 
    MANAGER_ID INT, 
    LOCATION_ID INT CONSTRAINT FK_LOCATION REFERENCES LOCATIONS(LOCATION_ID)
    );

CREATE TABLE EMPLOYEES(
    EMPLOYEE_ID INT PRIMARY KEY, 
    FIRST_NAME VARCHAR(25) NOT NULL, 
    LAST_NAME VARCHAR(25) NOT NULL, 
    EMAIL VARCHAR(50), 
    PHONE_NUMBER VARCHAR(15) NOT NULL, 
    HIRE_DATE DATE NOT NULL, 
    JOB_ID INT, 
    SALARY INT NOT NULL, 
    COMMISSION_PCT FLOAT(126) NOT NULL, 
    MANAGER_ID INT NOT NULL, 
    DEPARTMENT_ID INT
    );

ALTER TABLE EMPLOYEES ADD CONSTRAINT FK_EMPLOYEES_JOBS FOREIGN KEY (JOB_ID) REFERENCES JOBS(JOB_ID);
ALTER TABLE EMPLOYEES ADD CONSTRAINT FK_EMPLOYEES_DEPARTMENTS FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID);
ALTER TABLE EMPLOYEES ADD CONSTRAINT FK_EMPLOYEES_SELF FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID);
ALTER TABLE DEPARTMENTS ADD CONSTRAINT FK_DEPARTMENTS_EMPLOYEE FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID);

CREATE TABLE JOB_HISTORY(
    EMPLOYEE_ID INT, 
    START_DATE DATE, 
    END_DATE DATE NOT NULL, 
    JOB_ID INT, 
    DEPARTMENT_ID INT, 
    PRIMARY KEY(EMPLOYEE_ID, START_DATE)
    );

ALTER TABLE JOB_HISTORY ADD CONSTRAINT FK_JOBHISTORY_JOBS FOREIGN KEY (JOB_ID) REFERENCES JOBS(JOB_ID);
ALTER TABLE JOB_HISTORY ADD CONSTRAINT FK_JOBHISTORY_DEPARTMENT FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID);
ALTER TABLE JOB_HISTORY ADD CONSTRAINT FK_JOBHISTORY_EMPLOYEES FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID);