with leads as (
    select * from MARKETING.marketing.stg_leads
)

select
    lead_id,
    campaign_id,
    channel_id,
    lead_date,
    conversion_date,
    datediff('day', lead_date, conversion_date) as days_to_convert
from leads
where conversion_date is not null