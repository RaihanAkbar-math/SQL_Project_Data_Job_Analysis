/*
Optimal Skills to Learn for Data Analyst and Data Scientist around the world
*/

WITH demand_skill AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(*) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        (job_title_short = 'Data Analyst' OR job_title_short = 'Data Scientist')
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
), top_pay_skills AS (
    SELECT 
        skills_dim.skill_id,
        ROUND(AVG(salary_year_avg)) AS salary_skill
    FROM job_postings_fact
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        (job_title_short = 'Data Analyst' OR job_title_short = 'Data Scientist')
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
)


SELECT
    demand_skill.skills,
    demand_count,
    top_pay_skills.salary_skill AS average_salary
FROM demand_skill
INNER JOIN top_pay_skills
    ON demand_skill.skill_id = top_pay_skills.skill_id
WHERE
    demand_count >= 20
ORDER BY
    average_salary DESC,
    demand_count DESC
LIMIT 25;

-- Make it simple!
SELECT
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg)) AS average_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    (job_title_short = 'Data Analyst' OR job_title_short = 'Data Scientist') AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skills
HAVING
    COUNT(skills_job_dim.job_id) >= 20
ORDER BY
    average_salary DESC,
    demand_count DESC
LIMIT 25;