-- January Jobs Table
CREATE TABLE job_january AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date)=1;

-- February Jobs Table
CREATE TABLE job_february AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date)=2;

-- March Jobs Table
CREATE TABLE job_march AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date)=3;
-- Validation
select job_posted_date
from job_march;