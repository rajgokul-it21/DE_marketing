
  create or replace   view MARKETING.marketing.int_channel_spend
  
   as (
    with spend as (
    select * from MARKETING.marketing.stg_spend
),
channels as (
    select * from MARKETING.marketing.stg_channels
)

select 
    s.channel_id,
    c.channel_name,
    s.spend_date,
    s.amount
from spend s
left join channels c on s.channel_id = c.channel_id
  );

