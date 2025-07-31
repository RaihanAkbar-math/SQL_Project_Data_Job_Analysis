# 🧠 SQL for Data Analytics: Projects & Portfolio

Welcome to my SQL Portfolio! This repository showcases my learning journey and projects in **SQL for Data Analytics by Luke Barousse**, with real-world business insights derived from job postings metrics, company metrics, and skills metrics.  
This project explores 📊where high demand jobs meets high salary in data analytics and data scientists, 💰 top paying jobs and skills, and 🛠 popular skill needed!

🔍SQL queries? Check them out here: [SQL_Project Folder](/SQL_Project/)

---

# 📚 Background

The data used in this project comes from a job postings dataset with 200000+ rows including various features such as company information, job locations, required skills, offered benefits, and average salaries. Data hails from my [SQL Course](https://lukebarousse.com/sql).

| Section | Description |
|--------|-------------|
| 📘 [`/queries`](/SQL_Course/) | SQL queries covering aggregation, joins, window functions, CTEs, subqueries, and more |
| 📊 [`/projects`](/SQL_Project/) | End-to-end data analysis projects using SQL |

---

## ❓❓ The questions I wanted to answer through my SQL queries were :

1. What are the top-paying jobs for data analyst and data scientist in Indonesia?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for our desired role?
4. Which skills are associated with higher salary?
5. What are the most optimal skills to learn based on average salary and job demand?

I also do some enrichment queries to answer:
1. What are the most job postings company for Data Analytics or Data Scientist 
and they offer health insurance for it?
2. Where are top countries for Data Analyst job?
3. In Indonesia, what role should we looking to learn?

# 🛠 Tools I Used
Here’s my tech stack for this project:

🐘 PostgreSQL – The chosen database management system, ideal for handling the job posting data.

💻 SQL – The backbone od my analysis, allowing me to analyze job postings

📝 VSCode + SQLTools – For writing and testing queries

🌐 Git & GitHub – For version control and portfolio showcase

# 📈 The Analysis
Key analyses I performed using SQL:

### 💸 Top Paying Jobs

Found the highest-paying skills for data roles such as Data Analyst and Data Scientist in 2023 (Indonesia only).

```sql
SELECT
    job_id,
    job_title,
    company_dim.name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg AS salary_yearly_USD,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    (job_title_short = 'Data Analyst' OR job_title_short = 'Data Scientist')
    AND
    job_location like '%Indonesia%'
    AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

Here are three clear insights from that 2023 Indonesia top-paying data analyst / data scientist sample:

* **High-tier data roles (especially at major tech platforms) command a strong premium.** The top earners are a Data Scientist at Gojek (USD 157.5K) and a Marketing Data Analytics Manager at GoTo Group (USD 132.5K), indicating that seniority/strategic positioning (managerial or advanced data science) and brand-recognition companies pay substantially more than more junior or generic analyst roles.

* **Role specialization and title correlate with pay spread, but there’s overlap—Data Scientists tend to sit higher, yet advanced analysts or niche specialists can approach similar levels.** For example, “Data Scientist” and “Data Scientist (Lending)” roles cluster above \~90K, while specialized analyst roles (e.g., Merchant Success, Consumer Lending) reach 100K+; junior-level positions (e.g., Junior Data Analyst at Samsung) sit noticeably lower (\~77K), showing experience/seniority and domain focus matter.

* **Geography and employment type have modest impact relative to employer and role: Jakarta dominates the listings and pays competitively, while even contractor roles (e.g., Ninja Van’s contractor Data Analyst at 105K) can match or exceed some full-time positions—suggesting that for top-paying data work in Indonesia, company/role is a bigger driver than strict full-time vs. contractor status.**

![Top Paying Roles](/assets/top_paying_data_roles_indonesia_2023.png)


### 💰 Skills for Top Paying Jobs

Found the highest-paying skills for data roles in 2023 by joining the job postings with the skills data, providing employers value for high-compensation roles.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        company_dim.name AS company_name,
        job_location,
        salary_year_avg AS salary_yearly_USD,
        job_posted_date
    FROM
        job_postings_fact
    LEFT JOIN company_dim
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        (job_title_short = 'Data Analyst' OR job_title_short = 'Data Scientist')
        AND
        job_location like '%Indonesia%'
        AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim
    ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id;
```
Key Takeaways:
- **Python** and **SQL** dominate the landscape, reinforcing their importance in data science workflows.
- Skills like **Go**, **JavaScript**, and **R** also appear, indicating demand for versatile engineers who can work across stacks.

![Skills for Top Paying Jobs](/assets/top_skills_indonesia_2023.png)


### 📈In-demand skills
This helped jobseekers espcially for Data Analyst and Scientist in Indonesia to know what skills to focus on.

```sql
SELECT 
    skills,
    COUNT(*) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    (job_title_short = 'Data Analyst' OR job_title_short = 'Data Scientist')
    AND job_location LIKE 'Indonesia'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 10;
```

Here are three insights from the 2023 in-demand skills for Data Analyst / Data Scientist roles in Indonesia:

- **SQL, Python, and Excel** dominate demand. These top three skills (with counts 79, 66, and 56 respectively) form the core toolkit that employers prioritize, indicating strong value in mastering relational querying, general-purpose scripting/analysis, and spreadsheet-based data manipulation.

- **Traditional BI & statistical tools** still matter, but fall behind modern data stack basics. Tools like R (33), Tableau (30), and SAS (24) show meaningful but lower demand, suggesting that while statistical analysis and visualization are expected, they often complement rather than replace foundational skills.

- **Emerging/platform and infrastructure skills lag in frequency**. Skills such as Power BI (17), Hadoop (9), MySQL (9), and AWS (9) appear less often, implying that either these are more niche/specialized requirements or that many roles focus first on core analysis capabilities before platform-specific expertise.

![In-demand skills](/assets/in-demand%20skills.jpeg)

### ⚙ Top Paying Skill for Data Analyst and Data Scientist around the world

```sql
SELECT 
    skills,
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
    skills
ORDER BY
    salary_skill DESC
LIMIT 10;
```

Key Takeaways:

💰 Niche skills (RedHat, Elixir, Lua) offer top pay.

🤖 AI/NLP tools (Watson, Hugging Face) are highly valued.

📊 R ecosystem (RShiny, dplyr) still holds strong.

🧠 Blockchain (Solidity) and rare languages (Haskell) show high potential.

### 😎 The Most Optimal Skills
If we want to get the most optimal skills, we are looking for skills that high salary and high demand. So, we combine queries from point 3 and 4 of this project.

```sql
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
```

The code seems complicated but we can simplify it!

```sql
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
```

![Optimal Skills](/assets/optimal%20sklls.jpeg)

Here are three insights from the skill vs. salary scatter (Indonesia 2023):

- **Best risk-reward sweet spots are frameworks with both high demand and strong pay** — skills like PyTorch, TensorFlow, and Spark combine large demand counts (584, 665, 1133) with high average salaries (~$139K–$145K), making them high-leverage investments for someone aiming for visibility and compensation.

- **Niche/high-paying but low-demand skills exist—specialization premium**. Tools like Hugging Face, Theano, Neo4j, and MXNet show top-tier average salaries (around $145K–$157K) despite relatively small demand, suggesting deep specialization or emerging expertise can command a premium if you can land roles needing them.

- **Core data infrastructure and ecosystem skills** (e.g., Pandas, GCP, BigQuery, Kubernetes) cluster in the middle—they have moderate-to-high demand but slightly lower average salaries (~$132K–$134K), indicating they’re essential baseline competencies that support higher-tier modeling/engineering work rather than headline differentiators on their own.

### ❤️ Top Companies Hiring Data Analysts/Scientists with Health Insurance (2023)
I want to know the most job postings company for Data Analytics or Data Scientist 
and they offer health insurance for it.

```sql
SELECT
    company_dim.company_id,
    company_dim.name,
    company_dim.link,
    COUNT(job_postings.job_id) AS job_count
FROM 
    job_postings_fact AS job_postings
LEFT JOIN company_dim
    ON job_postings.company_id = company_dim.company_id
WHERE
    job_health_insurance = TRUE AND
    (job_title_short = 'Data Analyst' OR job_title_short = 'Data Scientist')
GROUP BY
    company_dim.company_id
ORDER BY
    job_count DESC
LIMIT 10;
```

| Rank | Company Name | Job Count | Company Link |
|------|----------------------------|-----------|------------------------------|
| 1 | Booz Allen Hamilton | 1658 | [Visit](http://www.boozallen.com/) |
| 2 | Guidehouse | 1224 | - |
| 3 | UnitedHealth Group | 826 | [Visit](https://www.unitedhealthgroup.com/) |
| 4 | Walmart | 747 | [Visit](https://www.walmart.com/) |
| 5 | Corporate | 419 | - |
| 6 | Centene Corporation | 384 | [Visit](http://www.centene.com/) |
| 7 | Get It Recruit - Information Technology | 324 | - |
| 8 | Kforce | 272 | [Visit](http://www.kforce.com/) |
| 9 | Robert Half | 255 | [Visit](http://www.rhi.com/) |
| 10 | Apple | 248 | [Visit](http://www.apple.com/) |


In 2023, several major companies showed strong demand for Data Analyst and Data Scientist roles while offering health insurance benefits. Here's what stands out:

- Booz Allen Hamilton leads the chart with 1,658 job postings, emphasizing their large-scale hiring and commitment to employee well-being.

- Guidehouse and UnitedHealth Group follow, with 1,224 and 826 postings respectively—highlighting opportunities in consulting and healthcare sectors.

- Tech and retail giants like Apple and Walmart also made the list, showcasing data roles across diverse industries.

- Companies like Kforce and Robert Half reflect the significant role of recruitment/staffing firms in placing data professionals.

This data reinforces that employers value data talent and are pairing that with competitive benefits, such as health insurance, to attract top candidates.

🌍 Location Trends
Observed geographical hiring patterns for data analyst jobs.

```sql
SELECT
    job_country,
    ROUND(AVG(salary_year_avg)) AS average_salary,
    COUNT(job_id) AS job_count
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_country IS NOT NULL
GROUP BY
    job_country
ORDER BY
    average_salary DESC,
    job_count DESC
LIMIT 25;
```

![Top Country for Data Analyst](/assets/top_country.jpeg)

- **Outliers with very high average salaries are based on tiny job counts.** Belarus shows an average of $400K but only has 1 job—this suggests either a highly specialized/exceptional listing or a data artifact, so treat such extremes with caution.

- **More representative markets (with multiple postings) cluster around $108K–$116K.** Countries like South Korea (17 jobs), Greece (16), and Malta/Finland (5 each) have more listings and show consistent mid-six-figure-ish averages, indicating a more stable signal for typical compensation in those regions.

- **Small sample countries still provide context but lack robustness.** Namibia and Chile have 2 jobs each with relatively high averages ($135K and $127K), which could point to niche demand or selective hiring—good to monitor if more data accumulates.

### 👜Top Data-Related Job Roles in Indonesia (2023)

![Top Data Job Roles](/assets/top%20role.jpeg)

Based on job postings data in 2023:

Data Engineer is the most in-demand role with over 1,000 listings, showing high demand for backend and pipeline-related skills.

Data Scientist and Data Analyst follow, indicating a balanced demand for both predictive modeling and business intelligence roles.

Roles like Software Engineer and Senior Data Engineer show that hybrid skill sets are increasingly valuable in the data domain.

🔍 Companies in Indonesia are heavily investing in infrastructure and analytics talent — signaling strong growth in the local data ecosystem.

📂 All SQL queries and results are in this repository!

# 📚 What I Learned
This project taught me:

🔹 Writing complex joins, subqueries, and aggregations

🔹 Translating business questions into SQL queries

🔹 Generating insights from raw job data

🔹 Presenting SQL work as a portfolio project on GitHub

# ✅ Conclusions
From this analysis, I discovered that:

💼 RedHat, Elixir, and Lua are among the highest-paying skills

🏆 A few companies dominate job postings in the data field

🏥 Health insurance is a commonly offered benefit

📍 Location and skill diversity influence job opportunities

✨ Feel free to explore the repository and SQL queries!
💬 Feedback is always welcome