
  create or replace   view MARKETING.marketing.tmp_campaign_lead_check
  
   as (
    select 
    campaign_id,
    count(*) as total_leads,
    sum(case when is_converted then 1 else 0 end) as total_conversions
from MARKETING.marketing.stg_leads
group by campaign_id
order by total_leads desc
  );

