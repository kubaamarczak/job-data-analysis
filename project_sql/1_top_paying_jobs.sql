/*
What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available in Berlin, Germany
- Focuses on job postings with specified salaries (remove NULLs)
- Highlight the top-paying opportunities for Data Analysts, offering insights into employment opportunities
*/

SElECT
    job_postings.job_id,
    job_postings.job_title,
    companies.name AS company_name,
    job_postings.job_location,
    job_postings.job_schedule_type,
    job_postings.salary_year_avg,
    job_postings.job_posted_date
FROM 
    job_postings_fact AS job_postings
LEFT JOIN company_dim AS companies ON companies.company_id = job_postings.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location LIKE '%Germany%' AND
    salary_year_avg IS NOT NULL
ORDER BY    
    salary_year_avg DESC
LIMIT 10;