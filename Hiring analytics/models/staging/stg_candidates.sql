SELECT
    candidate_id,
    role,
    location,
    experience,
    education,
    first_source,
    application_date
FROM {{ source('public', 'candidates') }}