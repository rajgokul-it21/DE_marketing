with source as (
    select  * from {{ source('marketing', 'raw_spend') }}
),

cleaned as (
    select
        spend_id,
        campaign_id,
        {{ clean_date('spend_date', "'DD/MM/YYYY'") }} as spend_date,
        try_to_number(replace(spend_amount, '$', '')) as spend_amount,
        lower(currency) as currency,
        {{ null_if_invalid('notes') }} as notes,
    from source
)

select * from cleaned 
