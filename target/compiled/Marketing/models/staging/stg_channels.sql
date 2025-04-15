with source as (
    select * from MARKETING.raw.raw_channels
),



cleaned as (
    select
        upper(trim(nullif(channel_id, ''))) as channel_id,
        lower(trim(nullif(channel_name, ''))) as channel_name,
        lower(trim(nullif(channel_type, ''))) as channel_type,
        initcap(trim(nullif(region, ''))) as region,
        
    nullif(
        case 
            when lower(description) in ('', 'n/a', 'none', 'null', '-') then null 
            else description
        end,
        ''
    )
 as description
    from source
)

select * from cleaned