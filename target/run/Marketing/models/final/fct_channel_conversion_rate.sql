
  
    

        create or replace transient table MARKETING.marketing.fct_channel_conversion_rate
         as
        (with conversions as (
    select * from MARKETING.marketing.int_lead_conversion
)

select
    channel_id,
    total_leads,
    converted_leads,
    round(converted_leads * 1.0 / nullif(total_leads, 0), 2) as conversion_rate
from conversions
order by conversion_rate desc
        );
      
  