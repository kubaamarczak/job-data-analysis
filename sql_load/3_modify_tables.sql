COPY company_dim
FROM '/Users/jakubmarczak/sql/sql_project_data_jobs/csv_files/company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM '/Users/jakubmarczak/sql/sql_project_data_jobs/csv_files/skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
FROM '/Users/jakubmarczak/sql/sql_project_data_jobs/csv_files/job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_job_dim
FROM '/Users/jakubmarczak/sql/sql_project_data_jobs/csv_files/skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

SELECT *
FROM job_postings_fact
LIMIT 50;

SELECT  
    COUNT(job_id) AS job_postings_count,
    job_schedule_type,
    AVG(salary_year_avg) AS sal_yearly_avg,
    AVG(salary_hour_avg) AS sal_hourly_avg
FROM job_postings_fact
WHERE
    job_posted_date > '2023-06-01'
GROUP BY
    job_schedule_type;

-- create tables for first 3 months of job postings
CREATE TABLE january_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT job_posted_date
FROM january_jobs;

SELECT job_posted_date
FROM february_jobs;

SELECT job_posted_date
FROM march_jobs;

-- case
SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN salary_year_avg IS NULL THEN 'Unknown'
        WHEN salary_year_avg < 100000 THEN 'Low'
        WHEN salary_year_avg <= 200000 THEN 'Standard'
        ELSE 'High'
    END AS salary_category
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY    
    salary_category;

-- subquery
SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;

-- cte
WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)

SELECT *
FROM january_jobs;

-- subquery
SELECT name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = TRUE)

-- cte
WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS number_of_postings
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT 
    company_dim.name AS company_name,
    company_job_count.number_of_postings
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    company_job_count.number_of_postings DESC;

-- top 5 most frequently mentioned skills in job postings
-- subquery dev
SELECT
    skill_id
FROM
    skills_job_dim
GROUP BY 
    skill_id
ORDER BY
    COUNT(*)  DESC
LIMIT 5

-- subquery full
SELECT
    skills
FROM
    skills_dim
WHERE skill_id IN (
    SELECT
        skill_id
    FROM
        skills_job_dim
    GROUP BY 
        skill_id
    ORDER BY
        COUNT(*) DESC
    LIMIT 5
)

WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM    
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_postings.job_work_from_home = TRUE AND 
        job_postings.job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)

SELECT 
    skills.skill_id,
    skills as skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;

-- union
SELECT *
FROM january_jobs
LIMIT 5

SELECT *
FROM february_jobs
LIMIT 5

SELECT *
FROM march_jobs
LIMIT 5

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs

-- practice problem
SELECT 
    q1_table.job_id,
    q1_table.job_title_short,
    skills.skills,
    skills.type
FROM (
    SELECT *
    FROM
        january_jobs

    UNION ALL

    SELECT *
    FROM
        february_jobs

    UNION ALL

    SELECT *
    FROM
        march_jobs
) AS q1_table
LEFT JOIN skills_job_dim AS skill_to_job ON skill_to_job.job_id = q1_table.job_id
LEFT JOIN skills_dim AS skills ON skills.skill_id = skill_to_job.skill_id
ORDER BY
    q1_table.job_id


-- practice problem 8

SELECT *
FROM (
    SELECT *
    FROM
        january_jobs

    UNION ALL

    SELECT *
    FROM
        february_jobs

    UNION ALL

    SELECT *
    FROM
        march_jobs
)
WHERE 
    salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC
































