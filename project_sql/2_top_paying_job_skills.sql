/*
What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- provide a detailed look at which high-paying jobs demand certain skills
*/

WITH top_paying_jobs AS (
    SElECT
        job_postings.job_id,
        job_postings.job_title,
        companies.name AS company_name,
        job_postings.salary_year_avg
    FROM 
        job_postings_fact AS job_postings
    LEFT JOIN company_dim AS companies ON companies.company_id = job_postings.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location LIKE '%Germany%' AND
        salary_year_avg IS NOT NULL
    ORDER BY    
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim AS skills_to_job ON top_paying_jobs.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
ORDER BY
    top_paying_jobs.salary_year_avg DESC

/*
SQL and BI tools (Tableau/Power BI) are the most consistently required skills across top-paying roles
*/