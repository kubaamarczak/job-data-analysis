/*
What are the most in-demand skills for Data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a Data analyst
- Focus on all job postings
*/

SELECT
    skills,
    COUNT(skills_to_job.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim AS skills_to_job ON job_postings_fact.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location LIKE '%Germany%'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5
