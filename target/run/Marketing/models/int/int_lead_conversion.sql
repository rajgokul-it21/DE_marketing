
  create or replace   view MARKETING.marketing.int_lead_conversion
  
   as (
    with leads as (
    select * from MARKETING.marketing.stg_leads
),
campaigns as (
    select * from MARKETING.marketing.stg_campaigns
),
channels as (
    select * from MARKETING.marketing.stg_channels
)

select 
    l.lead_id,
    l.campaign_id,
    l.channel_id,
    c.campaign_name,
    ch.channel_name,
    l.lead_status,
    case when l.lead_status = 'Converted' then 1 else 0 end as is_converted
from leads l
left join campaigns c on l.campaign_id = c.campaign_id
left join channels ch on l.channel_id = ch.channel_id
  );

