-- 05_analysis_queries.sql
-- Final analysis queries for validation, reporting, screenshots, and Power BI cross-checks.

-- 1) KPI summary
select * from mart.vw_kpi_summary;

-- 2) Product/domain summary
select *
from mart.vw_product_summary
order by complaints desc;

-- 3) Top issues
select *
from mart.vw_issue_summary
order by complaints desc
limit 20;

-- 4) Channel mix
select *
from mart.vw_channel_summary
order by complaints desc;

-- 5) Product + issue combinations
select *
from mart.vw_product_issue_summary
order by complaints desc
limit 20;

-- 6) Product performance
select *
from mart.vw_product_performance
order by complaints desc;

-- 7) Issue performance
select *
from mart.vw_issue_performance
order by complaints desc
limit 20;

-- 8) Channel performance
select *
from mart.vw_channel_performance
order by complaints desc;

-- 9) Product effort summary
select *
from mart.vw_product_effort_summary
order by complaints desc;

-- 10) Issue effort summary
select *
from mart.vw_issue_effort_summary
order by complaints desc
limit 20;

-- 11) Age bucket distribution
select *
from mart.vw_age_bucket_summary;

-- 12) Narrative-only product summary
select *
from mart.vw_product_narrative_summary
order by complaints desc;

-- 13) Narrative-only issue summary
select *
from mart.vw_issue_narrative_summary
order by complaints desc
limit 20;

-- 14) Priority matrix
select *
from mart.vw_priority_matrix
order by priority_score desc
limit 25;

-- 15) Tag summary
select *
from mart.vw_tag_summary
order by complaints desc
limit 20;