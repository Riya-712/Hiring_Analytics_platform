SELECT
    candidate_id,
    stage,
    event_date
FROM {{ source('public', 'events') }}