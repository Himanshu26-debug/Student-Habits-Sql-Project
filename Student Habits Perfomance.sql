CREATE TABLE habit(
student_id varchar(50),
age INT,
gender varchar(50),
study_hours_per_day NUMERIC,
social_media_hours NUMERIC,
netflix_hours NUMERIC,
part_time_job Varchar(50),
attendance_percentage NUMERIC,
sleep_hours NUMERIC,
diet_quality Varchar(50), 
exercise_frequency INT,
parental_education_level varchar(50),
internet_quality Varchar(50),
mental_health_rating INT,
extracurricular_participation varchar(50),
exam_score Numeric(10,2)
);

--View all students_records
SELECT * FROM habit;

--Get the name and score of all students
SELECT student_id, exam_score FROM habit;

--List all the female students
SELECT * FROM  habit
WHERE gender = 'Female';

--Students who study more than 4 hours per day
SELECT student_id,study_hours_per_day
FROM habit
WHERE study_hours_per_day > 4;

--Students who are doing part-time job
SELECT * FROM habit;
SELECT student_id, part_time_job 
FROM habit
WHERE part_time_job = 'Yes';

--Students who scored more than 90
SELECT exam_score
FROM habit
WHERE exam_score > 90;

--Students with top 5 highest marks
select * from habit; 
select student_id, exam_score
from habit
order by exam_score limit 5;

--Students with Highest attendance_percentage
select student_id, attendance_percentage
from habit
order by attendance_percentage desc;

--Average Exam Score
select avg(exam_score) AS Average_Score
from habit;

--Counts students by gender
SELECT gender, COUNT(*) AS count
FROM habit
GROUP BY gender;
select * from habit;

--Students whose exam score is more than average marks
select * 
from habit
where exam_score > (Select avg(exam_score) from habit);

--Categorizing Students with their exam score with new column
Select student_id, exam_score,
case 
	when exam_score >=90 then 'Excellent'
	when exam_score >=60 then 'Good'
	when exam_score >=35 then 'Average'
	else 'Poor'
end as Performance_Category
from habit;

--Students who sleep less than 6 hours and have mental health rating less than equal to 3
SELECT * FROM  habit
WHERE sleep_hours < 6 
AND mental_health_rating <= 3;

--Average exam score for each diet group having more than 10 students
SELECT diet_quality, AVG(exam_score) AS avg_score, COUNT (*) AS student_count
FROM habit
GROUP BY diet_quality
HAVING COUNT(*) > 10;

Select * from habit

-- With CTE ranked the students by exam score and return top 10
WITH ranked_students as (
SELECT student_id, exam_score,
         RANK() OVER (ORDER BY exam_score DESC) AS rank
  FROM habit)
SELECT * FROM ranked_students
WHERE RANK <=10
;

--Students whose attendance is greater than the average attendance of students who have same gender
SELECT student_id, gender, attendance_percentage 
FROM habit AS s1
WHERE attendance_percentage > (
SELECT AVG(attendance_percentage) FROM habit AS s2
WHERE s1.gender = s2.gender
);

--Each row shows the current student_id and its 3 steps ahead
SELECT student_id,
LEAD(student_id, 3) OVER(ORDER BY student_id) AS "Row_Number"
FROM habit;

--Students have total exam score by their gender
SELECT gender, SUM(exam_score)
FROM habit
GROUP BY gender;

--Assinging percentile ranks to students based on their exam scores
SELECT exam_score,
PERCENT_RANK() OVER(ORDER BY exam_score)
FROM habit;

--Students with their average exam scores by with and without part-time job
SELECT part_time_job, AVG(exam_score)
FROM habit
GROUP BY part_time_job;
