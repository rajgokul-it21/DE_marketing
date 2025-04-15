with source as (
    select * from {{ source('marketing', 'raw_campaigns') }}
),


cleaned as (
    select
        campaign_id,
        {{ clean_text('campaign_name') }} as campaign_name,
        upper({{ clean_text('channel_id') }}) as channel_id,
         {{ clean_date('start_date', "'MM/DD/YYYY'") }} as start_date,
        {{ clean_date('end_date', "'DD-MM-YYYY'") }} as end_date,
        {{ normalize_text('status', 'title') }} as status,
        {{ clean_text('owner') }} as owner,
        split(tags, ',') as tag_list
    from source
)

select * from cleaned
