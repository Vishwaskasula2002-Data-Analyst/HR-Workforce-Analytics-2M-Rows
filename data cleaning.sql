create table hr_raw_data (
Employee_ID varchar(100),
Full_Name varchar(100),
Department varchar(50),
Job_Title varchar(100),
Hire_Date varchar(50),
Performance_Rating varchar(100),
Experience_Years varchar(50),
Status varchar(100),
Work_Mode varchar(50),
Salary varchar(100),
Joining_Year varchar(50),
Country varchar(100),
City varchar(100),
Age varchar(50),
Job_Level varchar(100)
)     ------------------------------------creates table

select Employee_ID,count(*)
from hr_raw_data
group by Employee_ID 
having count(*)>1;
         ---------------------------------checks for duplicate rows

select Salary
from hr_raw_data
where Salary is null
     or Salary like '-%'
	 or Salary = '';
       ------------------------------------checks if salary has a problem like negative or null values

alter table hr_raw_data
alter column Salary type numeric using Salary::numeric;
           -------------------------------------------------------changes salary to numeric data type

update hr_raw_data
set Salary= abs(Salary)
where Salary<0;

--------------------------------------------------------------------changes all negative salaries to positives 

select Age,Experience_Years, count(*)
from hr_raw_data
where Age='' or Age is null or Age !~ '^[0-9]+$' or Experience_Years='' or Experience_Years is null or Experience_Years !~ '^[0-9]+$'
group by Age,Experience_Years;

-----------------------------------------------------------------------checks if age or experience is null or any wrong text is entered


alter table hr_raw_data
alter column Experience_Years type numeric using Experience_Years::numeric,
alter column Age type numeric using Age::numeric;

---------------------------------------------------------------------------------changes age and experience_years to numeric data type


update hr_raw_data
set Age= abs(Age)
where Age<0;
update hr_raw_data
set Experience_Years= abs(Experience_Years)
where Experience_Years<0;

---------------------------------------------------------------------------------changes all negative age or experience years to positives

select count(*)
FROM hr_raw_data 
WHERE experience_years>= age or (age-experience_years) < 18;

-------------------------------------------------------------------------------checks if experience is more than age by mistake 

DELETE
FROM hr_raw_data 
WHERE experience_years>= age or (age-experience_years) < 18;

-----------------------------------------------------------------------------------as result was just 21 we delete them because 21 out of 2 million is very less which wont help in any decision

DELETE FROM hr_raw_data
where salary<18000 and job_level ilike 'mid';

DELETE FROM hr_raw_data
where salary<20000 and job_level ilike 'senior';

DELETE FROM hr_raw_data
where salary<25000 and job_level ilike 'director';

----------------------------------------------------------------assuming minimum salaries I am deleting entries below minimum


ALTER TABLE hr_raw_data
ALTER COLUMN hire_date TYPE date USING to_date(hire_date, 'YYYY-MM-DD');

---------------------------------------------------------------------------changed date data type from text string to date

ALTER TABLE hr_raw_data
DROP COLUMN joining_year; 

----------------------------------------------------------------------------year was already written in hire_date so I deleted joining_year coloumn