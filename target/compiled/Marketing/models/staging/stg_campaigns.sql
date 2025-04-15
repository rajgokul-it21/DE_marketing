with source as (
    select * from MARKETING.raw.raw_campaigns
),


cleaned as (
    select
        campaign_id,
        
    lower(trim(nullif(campaign_name, '')))
 as campaign_name,
        upper(
    lower(trim(nullif(channel_id, '')))
) as channel_id,
         
    try_to_date(start_date, 'MM/DD/YYYY')
 as start_date,
        
    try_to_date(end_date, 'DD-MM-YYYY')
 as end_date,
        initcap(trim(nullif(status, ''))) as status,
        
    lower(trim(nullif(owner, '')))
 as owner,
        split(tags, ',') as tag_list
    from source
)

select * from cleaned