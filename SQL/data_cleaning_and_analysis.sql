---- Data Transformation ----

-- Get entries with patients who are still waiting to start treatment (64,894 entries)
SELECT COUNT(*)
FROM rtt_raw
WHERE "RTT Part Description" = 'Incomplete Pathways';

-- Get specialties
SELECT DISTINCT "Treatment Function Name"
FROM rtt_raw
WHERE "RTT Part Description" = 'Incomplete Pathways'
ORDER BY "Treatment Function Name";

SELECT *
FROM rtt_raw
WHERE "Treatment Function Name" = 'Total';

-- Remove 'Total' specialty and create table of 'Incomplete Pathways'
CREATE TABLE rtt_incomplete as
select *
from rtt_raw
where "RTT Part Description" = 'Incomplete Pathways' and "Treatment Function Name" != 'Total';

-- Get updated count (51,925 entries)
select count(*)
from rtt_incomplete;

-- Create new table with only provider org, treatment function, and weeks divided into bands
create table rtt as
select 
    "Provider Org Name",
    "Treatment Function Name",
    weeks_waiting,
    COALESCE(NULLIF(patient_count, ''), '0')::INT as patient_count
from rtt_incomplete
cross join lateral (
    values
        (1, "Gt 00 To 01 Weeks SUM 1"),
        (2, "Gt 01 To 02 Weeks SUM 1"),
        (3, "Gt 02 To 03 Weeks SUM 1"),
        (4, "Gt 03 To 04 Weeks SUM 1"),
        (5, "Gt 04 To 05 Weeks SUM 1"),
        (6, "Gt 05 To 06 Weeks SUM 1"),
        (7, "Gt 06 To 07 Weeks SUM 1"),
        (8, "Gt 07 To 08 Weeks SUM 1"),
        (9, "Gt 08 To 09 Weeks SUM 1"),
        (10, "Gt 09 To 10 Weeks SUM 1"),
        (11, "Gt 10 To 11 Weeks SUM 1"),
        (12, "Gt 11 To 12 Weeks SUM 1"),
        (13, "Gt 12 To 13 Weeks SUM 1"),
        (14, "Gt 13 To 14 Weeks SUM 1"),
        (15, "Gt 14 To 15 Weeks SUM 1"),
        (16, "Gt 15 To 16 Weeks SUM 1"),
        (17, "Gt 16 To 17 Weeks SUM 1"),
        (18, "Gt 17 To 18 Weeks SUM 1"),
        (19, "Gt 18 To 19 Weeks SUM 1"),
        (20, "Gt 19 To 20 Weeks SUM 1"),
        (21, "Gt 20 To 21 Weeks SUM 1"),
        (22, "Gt 21 To 22 Weeks SUM 1"),
        (23, "Gt 22 To 23 Weeks SUM 1"),
        (24, "Gt 23 To 24 Weeks SUM 1"),
        (25, "Gt 24 To 25 Weeks SUM 1"),
        (26, "Gt 25 To 26 Weeks SUM 1"),
        (27, "Gt 26 To 27 Weeks SUM 1"),
        (28, "Gt 27 To 28 Weeks SUM 1"),
        (29, "Gt 28 To 29 Weeks SUM 1"),
        (30, "Gt 29 To 30 Weeks SUM 1"),
        (31, "Gt 30 To 31 Weeks SUM 1"),
        (32, "Gt 31 To 32 Weeks SUM 1"),
        (33, "Gt 32 To 33 Weeks SUM 1"),
        (34, "Gt 33 To 34 Weeks SUM 1"),
        (35, "Gt 34 To 35 Weeks SUM 1"),
        (36, "Gt 35 To 36 Weeks SUM 1"),
        (37, "Gt 36 To 37 Weeks SUM 1"),
        (38, "Gt 37 To 38 Weeks SUM 1"),
        (39, "Gt 38 To 39 Weeks SUM 1"),
        (40, "Gt 39 To 40 Weeks SUM 1"),
        (41, "Gt 40 To 41 Weeks SUM 1"),
        (42, "Gt 41 To 42 Weeks SUM 1"),
        (43, "Gt 42 To 43 Weeks SUM 1"),
        (44, "Gt 43 To 44 Weeks SUM 1"),
        (45, "Gt 44 To 45 Weeks SUM 1"),
        (46, "Gt 45 To 46 Weeks SUM 1"),
        (47, "Gt 46 To 47 Weeks SUM 1"),
        (48, "Gt 47 To 48 Weeks SUM 1"),
        (49, "Gt 48 To 49 Weeks SUM 1"),
        (50, "Gt 49 To 50 Weeks SUM 1"),
        (51, "Gt 50 To 51 Weeks SUM 1"),
        (52, "Gt 51 To 52 Weeks SUM 1"),
        (53, "Gt 52 To 53 Weeks SUM 1"),
        (54, "Gt 53 To 54 Weeks SUM 1"),
        (55, "Gt 54 To 55 Weeks SUM 1"),
        (56, "Gt 55 To 56 Weeks SUM 1"),
        (57, "Gt 56 To 57 Weeks SUM 1"),
        (58, "Gt 57 To 58 Weeks SUM 1"),
        (59, "Gt 58 To 59 Weeks SUM 1"),
        (60, "Gt 59 To 60 Weeks SUM 1"),
        (61, "Gt 60 To 61 Weeks SUM 1"),
        (62, "Gt 61 To 62 Weeks SUM 1"),
        (63, "Gt 62 To 63 Weeks SUM 1"),
        (64, "Gt 63 To 64 Weeks SUM 1"),
        (65, "Gt 64 To 65 Weeks SUM 1"),
        (66, "Gt 65 To 66 Weeks SUM 1"),
        (67, "Gt 66 To 67 Weeks SUM 1"),
        (68, "Gt 67 To 68 Weeks SUM 1"),
        (69, "Gt 68 To 69 Weeks SUM 1"),
        (70, "Gt 69 To 70 Weeks SUM 1"),
        (71, "Gt 70 To 71 Weeks SUM 1"),
        (72, "Gt 71 To 72 Weeks SUM 1"),
        (73, "Gt 72 To 73 Weeks SUM 1"),
        (74, "Gt 73 To 74 Weeks SUM 1"),
        (75, "Gt 74 To 75 Weeks SUM 1"),
        (76, "Gt 75 To 76 Weeks SUM 1"),
        (77, "Gt 76 To 77 Weeks SUM 1"),
        (78, "Gt 77 To 78 Weeks SUM 1"),
        (79, "Gt 78 To 79 Weeks SUM 1"),
        (80, "Gt 79 To 80 Weeks SUM 1"),
        (81, "Gt 80 To 81 Weeks SUM 1"),
        (82, "Gt 81 To 82 Weeks SUM 1"),
        (83, "Gt 82 To 83 Weeks SUM 1"),
        (84, "Gt 83 To 84 Weeks SUM 1"),
        (85, "Gt 84 To 85 Weeks SUM 1"),
        (86, "Gt 85 To 86 Weeks SUM 1"),
        (87, "Gt 86 To 87 Weeks SUM 1"),
        (88, "Gt 87 To 88 Weeks SUM 1"),
        (89, "Gt 88 To 89 Weeks SUM 1"),
        (90, "Gt 89 To 90 Weeks SUM 1"),
        (91, "Gt 90 To 91 Weeks SUM 1"),
        (92, "Gt 91 To 92 Weeks SUM 1"),
        (93, "Gt 92 To 93 Weeks SUM 1"),
        (94, "Gt 93 To 94 Weeks SUM 1"),
        (95, "Gt 94 To 95 Weeks SUM 1"),
        (96, "Gt 95 To 96 Weeks SUM 1"),
        (97, "Gt 96 To 97 Weeks SUM 1"),
        (98, "Gt 97 To 98 Weeks SUM 1"),
        (99, "Gt 98 To 99 Weeks SUM 1"),
        (100, "Gt 99 To 100 Weeks SUM 1"),
        (101, "Gt 100 To 101 Weeks SUM 1"),
        (102, "Gt 101 To 102 Weeks SUM 1"),
        (103, "Gt 102 To 103 Weeks SUM 1"),
        (104, "Gt 103 To 104 Weeks SUM 1"),
        (105, "Gt 104 Weeks SUM 1")
) as t(weeks_waiting, patient_count);


-- Rename columns to provider and specialty
alter table rtt
rename column "Provider Org Name" to provider;

alter table rtt
rename column "Treatment Function Name" to specialty;


---- Data Analysis ----

-- Get number of entries in database (5,452,125)
select COUNT(*)
from rtt;

-- Get number and percentage of patients wating more than 18 weeks
select provider,
	   specialty,
	   SUM(case when weeks_waiting > 18 then patient_count else 0 end) as patients_more_than_18_weeks,
	   SUM(patient_count) AS total_patients_waiting,
	   ROUND(
	   (100 * SUM(case when weeks_waiting > 18 then patient_count else 0 end)::NUMERIC / SUM(patient_count))
	   , 2) as percentage_waiting_more_than_18_weeks
from rtt
group by provider, specialty
order by patients_more_than_18_weeks DESC;

-- Get number and percentage of patients waiting more that 1 year (52 weeks)
select provider,
	   specialty,
	   SUM(case when weeks_waiting > 52 then patient_count else 0 end) as patients_more_than_year,
	   SUM(patient_count) as total_patients_waiting,
	   ROUND(
	   (100 * SUM(case when weeks_waiting > 52 then patient_count else 0 end)::NUMERIC / SUM(patient_count))
	   , 2) as percentage_waiting_more_than_year
from rtt
group by provider, specialty
order by patients_more_than_year desc;

-- Find specialties with most patients waiting over a year
with more_than_year as (
select specialty,
	   SUM(case when weeks_waiting > 52 then patient_count else 0 end) as patients_more_than_year,
	   SUM(patient_count) as total_patients_waiting,
	   ROUND(
	   (100 * SUM(case when weeks_waiting > 52 then patient_count else 0 end)::NUMERIC / SUM(patient_count))
	   , 2) as percentage_waiting_more_than_year
from rtt
group by specialty
)
select specialty,
	   patients_more_than_year,
	   total_patients_waiting,
	   ROUND(
	   (100.0 * patients_more_than_year::NUMERIC / total_patients_waiting)
	   , 2) as percentage_waiting_more_than_year_specialty
from more_than_year
order by patients_more_than_year desc
limit 10;

-- Find providers with most patients waiting over a year
with more_than_year as (
	select provider,
	   	   SUM(case when weeks_waiting > 52 then patient_count else 0 end) as patients_more_than_year,
	       SUM(patient_count) as total_patients_waiting,
	       ROUND(
	       (100 * SUM(case when weeks_waiting > 52 then patient_count else 0 end)::NUMERIC / SUM(patient_count))
	       , 2) as percentage_waiting_more_than_year
from rtt
group by provider
)
select provider,
	   patients_more_than_year,
	   total_patients_waiting,
	   ROUND(
	   (100 * patients_more_than_year::NUMERIC / total_patients_waiting)
	   , 2) as percentage_waiting_more_than_year_provider
from more_than_year
order by patients_more_than_year desc
limit 10;

-- Get waiting time distributions
select weeks_waiting, SUM(patient_count) as total_patients_waiting_week
from rtt
group by weeks_waiting
order by weeks_waiting;

-- Get average wait time
select provider,
	   specialty,
	   SUM(weeks_waiting * patient_count) as total_weeks,
	   SUM(patient_count) as total_patients_waiting,
	   ROUND(
	   SUM(weeks_waiting * patient_count)::NUMERIC / SUM(patient_count)
	   , 2) as avg_wait_time_weeks
from rtt
group by provider, specialty
order by avg_wait_time_weeks desc;

-- Find specialties with longest average wait time
select specialty,
	   SUM(weeks_waiting * patient_count) as total_weeks_waiting,
	   SUM(patient_count) as total_patients_waiting,
	   ROUND(
	   	    SUM(weeks_waiting * patient_count)::NUMERIC / SUM(patient_count)
	        , 2) as avg_wait_time_weeks
	from rtt
	group by specialty
	order by avg_wait_time_weeks desc
	limit 10;

-- Find providers with longest average wait time
select provider,
	   SUM(weeks_waiting * patient_count) as total_weeks_waiting,
	   SUM(patient_count) as total_patients_waiting,
	   ROUND(
	   	    SUM(weeks_waiting * patient_count)::NUMERIC / SUM(patient_count)
	        , 2) as avg_wait_time_weeks
	from rtt
	group by provider
	order by avg_wait_time_weeks desc
	limit 10;

-- % waiting more than 18 weeks, number of patients waiting more 52 weeks, average wait time (KPI summary for dashboard)
select ROUND(
	   (100 * SUM(case when weeks_waiting > 18 then patient_count else 0 end)::NUMERIC / SUM(patient_count))
	   , 2) as percentage_waiting_more_than_18_weeks,
	   ROUND(
	   (100 * SUM(case when weeks_waiting > 52 then patient_count else 0 end)::NUMERIC / SUM(patient_count))
	   , 2) as percentage_waiting_more_than_year,
	   ROUND(
	   SUM(weeks_waiting * patient_count)::NUMERIC / SUM(patient_count)
	   , 2) as avg_wait_time_weeks
from rtt;




