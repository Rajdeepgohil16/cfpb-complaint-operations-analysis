CREATE SCHEMA IF NOT EXISTS stg;
CREATE SCHEMA IF NOT EXISTS mart;

CREATE TABLE IF NOT EXISTS stg.complaints_scoped (
    complaint_id TEXT,
    date_received DATE,
    date_sent_to_company DATE,
    as_of_date DATE,
    company_raw TEXT,
    company_std TEXT,
    product_raw TEXT,
    product_std TEXT,
    product_domain TEXT,
    domain_is_focus_flag INTEGER,
    issue_raw TEXT,
    issue_std TEXT,
    sub_product_std TEXT,
    sub_issue_std TEXT,
    state TEXT,
    zip3 TEXT,
    zip5 TEXT,
    channel_std TEXT,
    company_response_to_consumer TEXT,
    company_public_response TEXT,
    timely_flag INTEGER,
    disputed_flag INTEGER,
    has_narrative_flag INTEGER,
    narrative_length_chars INTEGER,
    intake_to_routing_days INTEGER,
    lag_negative_flag INTEGER,
    days_since_received INTEGER,
    days_since_received_bucket TEXT,
    heavy_channel_flag INTEGER,
    consent_std TEXT,
    long_narrative_flag INTEGER,
    untimely_flag INTEGER,
    dispute_flag INTEGER,
    effort_score INTEGER,
    effort_unknown_flag INTEGER
);

CREATE TABLE IF NOT EXISTS stg.complaint_tag_bridge (
    complaint_id TEXT,
    tag TEXT
);
