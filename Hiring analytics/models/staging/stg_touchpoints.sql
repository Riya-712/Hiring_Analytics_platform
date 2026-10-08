SELECT
    candidate_id,
    touch_order,
    source,
    touch_date
FROM {{ source('public', 'touchpoints') }}