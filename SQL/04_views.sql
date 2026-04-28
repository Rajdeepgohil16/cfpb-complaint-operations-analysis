-- 04_views.sql

CREATE SCHEMA IF NOT EXISTS mart;

-- KPI summary
CREATE OR REPLACE VIEW mart.vw_kpi_summary AS
SELECT
    COUNT(*) AS total_complaints,
    ROUND(AVG(timely_flag::numeric), 4) AS timely_rate,
    ROUND(AVG(untimely_flag::numeric), 4) AS untimely_rate,
    ROUND(AVG(heavy_channel_flag::numeric), 4) AS heavy_channel_share,
    ROUND(AVG(effort_score::numeric), 4) AS avg_effort_score,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY intake_to_routing_days) AS median_intake_to_routing_days,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY days_since_received) AS median_days_since_received
FROM stg.complaints_scoped;

-- Product/domain summary
CREATE OR REPLACE VIEW mart.vw_product_summary AS
SELECT
    product_domain,
    COUNT(*) AS complaints,
    ROUND(COUNT(*) * 1.0 / SUM(COUNT(*)) OVER (), 4) AS share,
    ROUND(AVG(untimely_flag::numeric), 4) AS untimely_rate,
    ROUND(AVG(heavy_channel_flag::numeric), 4) AS heavy_channel_share,
    ROUND(AVG(effort_score::numeric), 4) AS avg_effort_score,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY intake_to_routing_days) AS median_intake_to_routing_days,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY days_since_received) AS median_days_since_received
FROM stg.complaints_scoped
GROUP BY product_domain
ORDER BY complaints DESC;

-- Issue summary
CREATE OR REPLACE VIEW mart.vw_issue_summary AS
SELECT
    issue_std,
    COUNT(*) AS complaints,
    ROUND(AVG(untimely_flag::numeric), 4) AS untimely_rate,
    ROUND(AVG(heavy_channel_flag::numeric), 4) AS heavy_channel_share,
    ROUND(AVG(effort_score::numeric), 4) AS avg_effort_score,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY intake_to_routing_days) AS median_intake_to_routing_days,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY days_since_received) AS median_days_since_received
FROM stg.complaints_scoped
GROUP BY issue_std
ORDER BY complaints DESC;

-- Channel summary
CREATE OR REPLACE VIEW mart.vw_channel_summary AS
SELECT
    channel_std,
    COUNT(*) AS complaints,
    ROUND(COUNT(*) * 1.0 / SUM(COUNT(*)) OVER (), 4) AS share,
    ROUND(AVG(untimely_flag::numeric), 4) AS untimely_rate,
    ROUND(AVG(heavy_channel_flag::numeric), 4) AS heavy_channel_share,
    ROUND(AVG(effort_score::numeric), 4) AS avg_effort_score
FROM stg.complaints_scoped
GROUP BY channel_std
ORDER BY complaints DESC;

-- Product + issue summary
CREATE OR REPLACE VIEW mart.vw_product_issue_summary AS
SELECT
    product_domain,
    issue_std,
    COUNT(*) AS complaints
FROM stg.complaints_scoped
GROUP BY product_domain, issue_std
ORDER BY complaints DESC;

-- Product performance summary
CREATE OR REPLACE VIEW mart.vw_product_performance AS
SELECT
    product_domain,
    COUNT(*) AS complaints,
    ROUND(AVG(untimely_flag::numeric), 4) AS untimely_rate,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY intake_to_routing_days) AS median_intake_to_routing_days,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY days_since_received) AS median_days_since_received
FROM stg.complaints_scoped
GROUP BY product_domain
ORDER BY complaints DESC;

-- Issue performance summary
CREATE OR REPLACE VIEW mart.vw_issue_performance AS
SELECT
    issue_std,
    COUNT(*) AS complaints,
    ROUND(AVG(untimely_flag::numeric), 4) AS untimely_rate,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY intake_to_routing_days) AS median_intake_to_routing_days,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY days_since_received) AS median_days_since_received
FROM stg.complaints_scoped
GROUP BY issue_std
ORDER BY complaints DESC;

-- Channel performance summary
CREATE OR REPLACE VIEW mart.vw_channel_performance AS
SELECT
    channel_std,
    COUNT(*) AS complaints,
    ROUND(AVG(untimely_flag::numeric), 4) AS untimely_rate,
    ROUND(AVG(heavy_channel_flag::numeric), 4) AS heavy_channel_share,
    ROUND(AVG(effort_score::numeric), 4) AS avg_effort_proxy
FROM stg.complaints_scoped
GROUP BY channel_std
ORDER BY complaints DESC;

-- Workload / effort by product
CREATE OR REPLACE VIEW mart.vw_product_effort_summary AS
SELECT
    product_domain,
    COUNT(*) AS complaints,
    ROUND(AVG(heavy_channel_flag::numeric), 4) AS heavy_channel_share,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY narrative_length_chars)
        FILTER (WHERE has_narrative_flag = 1) AS median_narrative_length,
    ROUND(AVG(untimely_flag::numeric), 4) AS untimely_rate,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY intake_to_routing_days) AS median_intake_to_routing_days,
    ROUND(AVG(effort_score::numeric), 4) AS avg_effort_proxy
FROM stg.complaints_scoped
GROUP BY product_domain
ORDER BY complaints DESC;

-- Workload / effort by issue
CREATE OR REPLACE VIEW mart.vw_issue_effort_summary AS
SELECT
    issue_std,
    COUNT(*) AS complaints,
    ROUND(AVG(heavy_channel_flag::numeric), 4) AS heavy_channel_share,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY narrative_length_chars)
        FILTER (WHERE has_narrative_flag = 1) AS median_narrative_length,
    ROUND(AVG(untimely_flag::numeric), 4) AS untimely_rate,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY intake_to_routing_days) AS median_intake_to_routing_days,
    ROUND(AVG(effort_score::numeric), 4) AS avg_effort_proxy
FROM stg.complaints_scoped
GROUP BY issue_std
ORDER BY complaints DESC;

-- Age bucket distribution
CREATE OR REPLACE VIEW mart.vw_age_bucket_summary AS
SELECT
    CASE
        WHEN days_since_received BETWEEN 0 AND 90 THEN '0–90'
        WHEN days_since_received BETWEEN 91 AND 180 THEN '91–180'
        WHEN days_since_received BETWEEN 181 AND 365 THEN '181–365'
        ELSE '365+'
    END AS age_bucket_hist,
    COUNT(*) AS complaints,
    ROUND(COUNT(*) * 1.0 / SUM(COUNT(*)) OVER (), 4) AS share
FROM stg.complaints_scoped
GROUP BY 1
ORDER BY
    CASE
        WHEN age_bucket_hist = '0–90' THEN 1
        WHEN age_bucket_hist = '91–180' THEN 2
        WHEN age_bucket_hist = '181–365' THEN 3
        ELSE 4
    END;

-- Narrative-only product summary
CREATE OR REPLACE VIEW mart.vw_product_narrative_summary AS
SELECT
    product_domain,
    COUNT(*) AS complaints
FROM stg.complaints_scoped
WHERE has_narrative_flag = 1
GROUP BY product_domain
ORDER BY complaints DESC;

-- Narrative-only issue summary
CREATE OR REPLACE VIEW mart.vw_issue_narrative_summary AS
SELECT
    issue_std,
    COUNT(*) AS complaints
FROM stg.complaints_scoped
WHERE has_narrative_flag = 1
GROUP BY issue_std
ORDER BY complaints DESC;

-- Priority matrix
CREATE OR REPLACE VIEW mart.vw_priority_matrix AS
SELECT
    product_domain,
    issue_std,
    channel_std,
    COUNT(*) AS complaints,
    ROUND(AVG(untimely_flag::numeric), 4) AS untimely_rate,
    ROUND(AVG(heavy_channel_flag::numeric), 4) AS heavy_channel_share,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY intake_to_routing_days) AS median_intake_to_routing_days,
    ROUND(AVG(CASE WHEN days_since_received > 180 THEN 1.0 ELSE 0.0 END), 4) AS older_hist_share,
    ROUND(
        (
            LN(COUNT(*) + 1) * 0.45
            + AVG(untimely_flag::numeric) * 0.25
            + AVG(heavy_channel_flag::numeric) * 0.20
            + AVG(CASE WHEN days_since_received > 180 THEN 1.0 ELSE 0.0 END) * 0.10
        )::numeric,
        4
    ) AS priority_score
FROM stg.complaints_scoped
GROUP BY product_domain, issue_std, channel_std
ORDER BY priority_score DESC;

-- Tag summary
CREATE OR REPLACE VIEW mart.vw_tag_summary AS
SELECT
    tag,
    COUNT(*) AS complaints
FROM stg.complaint_tag_bridge
GROUP BY tag
ORDER BY complaints DESC;