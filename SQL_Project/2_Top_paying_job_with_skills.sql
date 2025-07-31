/*
What skills are required for the top-paying data analyst jobs?
    - Use the top 10 highest-paying Data Analyst jobs from first query
    - Add the specific skills required for these roles
    - Why? It provides a detailed look at which high-paying jobs demand certain skills.
    Helping job seekers understand which skills to develop that align with top salaries?
*/


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

/*
Here’s a bar chart showing the **Top 10 Most In-Demand Skills** among top-paying data analyst and data scientist roles in Indonesia (2023):

📊 **[Download the image](sandbox:/mnt/data/top_skills_indonesia_2023.png)** for your LinkedIn post or GitHub README.

### 📝 Suggested GitHub Markdown

```markdown
## 🔍 Top In-Demand Skills in High-Paying Data Roles (Indonesia, 2023)

The chart below highlights the most frequently mentioned technical skills from job postings for data analyst and data scientist positions in Indonesia offering top-tier salaries in 2023.

![Top Skills](top_skills_indonesia_2023.png)

Key Takeaways:
- **Python** and **SQL** dominate the landscape, reinforcing their importance in data science workflows.
- Skills like **Go**, **JavaScript**, and **R** also appear, indicating demand for versatile engineers who can work across stacks.
```

### 💬 Suggested LinkedIn Caption

> 📈 Curious about the most valued skills for top-paying Data roles in Indonesia?
>
> I analyzed 2023 job postings for Data Analyst and Data Scientist positions and visualized the most in-demand skills. Python and SQL clearly lead the pack!
>
> 🚀 Check out the full analysis and chart on my GitHub: *\[insert GitHub link here]*
>
> \#DataScience #Indonesia #DataAnalyst #JobMarket #Python #SQL

``` 
[
  {
    "job_id": 161639,
    "job_title": "Data Scientist - GoPay",
    "company_name": "Gojek",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "157500.0",
    "job_posted_date": "2023-01-30 11:19:18",
    "skills": "python"
  },
  {
    "job_id": 161639,
    "job_title": "Data Scientist - GoPay",
    "company_name": "Gojek",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "157500.0",
    "job_posted_date": "2023-01-30 11:19:18",
    "skills": "go"
  },
  {
    "job_id": 1771851,
    "job_title": "Marketing Data Analytics Manager",
    "company_name": "GoTo Group",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "132500.0",
    "job_posted_date": "2023-08-03 10:18:35",
    "skills": "sql"
  },
  {
    "job_id": 1771851,
    "job_title": "Marketing Data Analytics Manager",
    "company_name": "GoTo Group",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "132500.0",
    "job_posted_date": "2023-08-03 10:18:35",
    "skills": "python"
  },
  {
    "job_id": 1771851,
    "job_title": "Marketing Data Analytics Manager",
    "company_name": "GoTo Group",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "132500.0",
    "job_posted_date": "2023-08-03 10:18:35",
    "skills": "javascript"
  },
  {
    "job_id": 1771851,
    "job_title": "Marketing Data Analytics Manager",
    "company_name": "GoTo Group",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "132500.0",
    "job_posted_date": "2023-08-03 10:18:35",
    "skills": "excel"
  },
  {
    "job_id": 1771851,
    "job_title": "Marketing Data Analytics Manager",
    "company_name": "GoTo Group",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "132500.0",
    "job_posted_date": "2023-08-03 10:18:35",
    "skills": "tableau"
  },
  {
    "job_id": 1771851,
    "job_title": "Marketing Data Analytics Manager",
    "company_name": "GoTo Group",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "132500.0",
    "job_posted_date": "2023-08-03 10:18:35",
    "skills": "power bi"
  },
  {
    "job_id": 176019,
    "job_title": "Data Analyst - Merchant Success",
    "company_name": "BukuWarung",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "111175.0",
    "job_posted_date": "2023-02-03 12:39:23",
    "skills": "sql"
  },
  {
    "job_id": 176019,
    "job_title": "Data Analyst - Merchant Success",
    "company_name": "BukuWarung",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "111175.0",
    "job_posted_date": "2023-02-03 12:39:23",
    "skills": "python"
  },
  {
    "job_id": 176019,
    "job_title": "Data Analyst - Merchant Success",
    "company_name": "BukuWarung",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "111175.0",
    "job_posted_date": "2023-02-03 12:39:23",
    "skills": "r"
  },
  {
    "job_id": 413113,
    "job_title": "Data Analyst - Consumer Lending",
    "company_name": "GoTo Group",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "105000.0",
    "job_posted_date": "2023-08-30 02:37:44",
    "skills": "sql"
  },
  {
    "job_id": 413113,
    "job_title": "Data Analyst - Consumer Lending",
    "company_name": "GoTo Group",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "105000.0",
    "job_posted_date": "2023-08-30 02:37:44",
    "skills": "python"
  },
  {
    "job_id": 413113,
    "job_title": "Data Analyst - Consumer Lending",
    "company_name": "GoTo Group",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "105000.0",
    "job_posted_date": "2023-08-30 02:37:44",
    "skills": "tableau"
  },
  {
    "job_id": 413113,
    "job_title": "Data Analyst - Consumer Lending",
    "company_name": "GoTo Group",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "105000.0",
    "job_posted_date": "2023-08-30 02:37:44",
    "skills": "looker"
  },
  {
    "job_id": 1516589,
    "job_title": "Customer Loyalty SLA Control Tower & Data Analyst",
    "company_name": "Ninja Van",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "105000.0",
    "job_posted_date": "2023-08-14 07:17:07",
    "skills": "excel"
  },
  {
    "job_id": 869889,
    "job_title": "(Operation) Data Analyst Manual Activity",
    "company_name": "Ninja Van",
    "job_location": "Yogyakarta, Yogyakarta City, Special Region of Yogyakarta, Indonesia",
    "salary_yearly_usd": "102500.0",
    "job_posted_date": "2023-04-05 07:18:38",
    "skills": "sql"
  },
  {
    "job_id": 869889,
    "job_title": "(Operation) Data Analyst Manual Activity",
    "company_name": "Ninja Van",
    "job_location": "Yogyakarta, Yogyakarta City, Special Region of Yogyakarta, Indonesia",
    "salary_yearly_usd": "102500.0",
    "job_posted_date": "2023-04-05 07:18:38",
    "skills": "excel"
  },
  {
    "job_id": 1367719,
    "job_title": "Data Analyst",
    "company_name": "Stockbit",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "100500.0",
    "job_posted_date": "2023-06-08 18:37:59",
    "skills": "sql"
  },
  {
    "job_id": 1367719,
    "job_title": "Data Analyst",
    "company_name": "Stockbit",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "100500.0",
    "job_posted_date": "2023-06-08 18:37:59",
    "skills": "tableau"
  },
  {
    "job_id": 145888,
    "job_title": "Data Scientist (Lending)",
    "company_name": "Moladin",
    "job_location": "South Jakarta, South Jakarta City, Jakarta, Indonesia",
    "salary_yearly_usd": "90670.0",
    "job_posted_date": "2023-06-22 20:24:06",
    "skills": "sql"
  },
  {
    "job_id": 145888,
    "job_title": "Data Scientist (Lending)",
    "company_name": "Moladin",
    "job_location": "South Jakarta, South Jakarta City, Jakarta, Indonesia",
    "salary_yearly_usd": "90670.0",
    "job_posted_date": "2023-06-22 20:24:06",
    "skills": "python"
  },
  {
    "job_id": 141221,
    "job_title": "Data Scientist",
    "company_name": "NielsenIQ",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "90000.5",
    "job_posted_date": "2023-11-04 09:54:41",
    "skills": "tableau"
  },
  {
    "job_id": 141221,
    "job_title": "Data Scientist",
    "company_name": "NielsenIQ",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "90000.5",
    "job_posted_date": "2023-11-04 09:54:41",
    "skills": "git"
  },
  {
    "job_id": 141221,
    "job_title": "Data Scientist",
    "company_name": "NielsenIQ",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "90000.5",
    "job_posted_date": "2023-11-04 09:54:41",
    "skills": "bitbucket"
  },
  {
    "job_id": 141221,
    "job_title": "Data Scientist",
    "company_name": "NielsenIQ",
    "job_location": "Jakarta, Indonesia",
    "salary_yearly_usd": "90000.5",
    "job_posted_date": "2023-11-04 09:54:41",
    "skills": "atlassian"
  },
  {
    "job_id": 1467344,
    "job_title": "Data Analyst - Junior",
    "company_name": "Samsung Electronics",
    "job_location": "Indonesia",
    "salary_yearly_usd": "77017.5",
    "job_posted_date": "2023-12-15 11:38:16",
    "skills": "sql"
  },
  {
    "job_id": 1467344,
    "job_title": "Data Analyst - Junior",
    "company_name": "Samsung Electronics",
    "job_location": "Indonesia",
    "salary_yearly_usd": "77017.5",
    "job_posted_date": "2023-12-15 11:38:16",
    "skills": "python"
  },
  {
    "job_id": 1467344,
    "job_title": "Data Analyst - Junior",
    "company_name": "Samsung Electronics",
    "job_location": "Indonesia",
    "salary_yearly_usd": "77017.5",
    "job_posted_date": "2023-12-15 11:38:16",
    "skills": "aws"
  },
  {
    "job_id": 1467344,
    "job_title": "Data Analyst - Junior",
    "company_name": "Samsung Electronics",
    "job_location": "Indonesia",
    "salary_yearly_usd": "77017.5",
    "job_posted_date": "2023-12-15 11:38:16",
    "skills": "excel"
  }
]
```
*/