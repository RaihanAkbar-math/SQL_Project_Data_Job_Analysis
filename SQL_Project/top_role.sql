-- Top jobs in Indonesia for Data Nerds!

SELECT
    job_title_short,
    COUNT(job_id) AS job_count
FROM
    job_postings_fact
WHERE
    job_country = 'Indonesia'
GROUP BY
    job_title_short
ORDER BY
    job_count DESC;

/*
📈 Insight: Top Data-Related Job Roles in Indonesia (2023)
Based on job postings data in 2023:

Data Engineer is the most in-demand role with over 1,000 listings, showing high demand for backend and pipeline-related skills.

Data Scientist and Data Analyst follow, indicating a balanced demand for both predictive modeling and business intelligence roles.

Roles like Software Engineer and Senior Data Engineer show that hybrid skill sets are increasingly valuable in the data domain.

🔍 Companies in Indonesia are heavily investing in infrastructure and analytics talent — signaling strong growth in the local data ecosystem.
*/