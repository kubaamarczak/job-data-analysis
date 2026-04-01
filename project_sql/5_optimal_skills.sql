/*
What are the most optimal skills to learn (high-demand and high-paying)
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on positions in Germany with specified salaries
*/

-- developing query
WITH skills_demand AS (
    SELECT
        skills.skill_id,
        skills.skills,
        COUNT(skills_to_job.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim AS skills_to_job ON job_postings_fact.job_id = skills_to_job.job_id
    INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_location LIKE '%Germany%'
    GROUP BY
        skills.skill_id
), average_salary AS (
    SELECT
        skills_to_job.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim AS skills_to_job ON job_postings_fact.job_id = skills_to_job.job_id
    INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_location LIKE '%Germany%'
    GROUP BY
        skills_to_job.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 3
ORDER BY    
    avg_salary DESC,
    demand_count DESC
LIMIT 25


-- rewriting more concisely
SELECT 
    skills.skill_id,
    skills.skills,
    COUNT(skills_to_job.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim AS skills_to_job ON job_postings_fact.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_location LIKE '%Germany%'
GROUP BY
    skills.skill_id 
HAVING
    COUNT(skills_to_job.job_id) > 3
ORDER BY    
    avg_salary DESC,
    demand_count DESC
LIMIT 25

