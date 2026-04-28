-- 03_validation.sql

-- Row counts
select 'complaints_scoped' as table_name, count(*) as row_count
from stg.complaints_scoped
union all
select 'complaint_tag_bridge' as table_name, count(*) as row_count
from stg.complaint_tag_bridge;

-- Null complaint_id check
select
    count(*) as null_or_blank_complaint_id
from stg.complaints_scoped
where complaint_id is null or trim(complaint_id) = '';

-- Duplicate complaint_id check in staged complaints
select
    complaint_id,
    count(*) as cnt
from stg.complaints_scoped
where complaint_id is not null and trim(complaint_id) <> ''
group by complaint_id
having count(*) > 1
order by cnt desc, complaint_id
limit 20;

-- Tag bridge rows that do not match a complaint
select
    count(*) as bridge_rows_without_match
from stg.complaint_tag_bridge b
left join stg.complaints_scoped c
    on b.complaint_id = c.complaint_id
where c.complaint_id is null;

-- Domain distribution
select
    product_domain,
    count(*) as complaints
from stg.complaints_scoped
group by product_domain
order by complaints desc;

-- Channel distribution
select
    channel_std,
    count(*) as complaints
from stg.complaints_scoped
group by channel_std
order by complaints desc;

-- Timely flag completeness
select
    count(*) as total_rows,
    sum(case when timely_flag is null then 1 else 0 end) as timely_flag_nulls,
    sum(case when disputed_flag is null then 1 else 0 end) as disputed_flag_nulls
from stg.complaints_scoped;

-- Negative lag check
select
    count(*) as negative_lag_rows
from stg.complaints_scoped
where lag_negative_flag = 1;

-- Date range check
select
    min(date_received) as min_date_received,
    max(date_received) as max_date_received,
    min(as_of_date) as min_as_of_date,
    max(as_of_date) as max_as_of_date
from stg.complaints_scoped;

-- Sample top tags
select
    tag,
    count(*) as tag_count
from stg.complaint_tag_bridge
group by tag
order by tag_count desc
limit 20;