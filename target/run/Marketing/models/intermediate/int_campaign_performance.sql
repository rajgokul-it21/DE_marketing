
  
    

        create or replace transient table MARKETING.marketing.int_campaign_performance
         as
        (with spend as (
    select
        campaign_id,
        sum(spend_amount) as total_spend
    from MARKETING.marketing.stg_spend
    group by campaign_id
),

leads as (
    select
        campaign_id,
        count(*) as total_leads,
        count_if(is_converted) as converted_leads
    from MARKETING.marketing.stg_leads
    group by campaign_id
)

select
    c.campaign_id,
    c.campaign_name,
    c.channel_id,
    c.start_date,
    c.end_date,
    s.total_spend,
    l.total_leads,
    l.converted_leads
from MARKETING.marketing.stg_campaigns c
left join spend s on c.campaign_id = s.campaign_id
left join leads l on c.campaign_id = l.campaign_id
        );
      
  