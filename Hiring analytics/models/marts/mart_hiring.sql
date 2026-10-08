SELECT
    c.candidate_id,
    c.first_source,

    f.applied_date,
    f.hired_date,

    (f.hired_date - f.applied_date) AS time_to_hire,

    CASE 
        WHEN f.hired_date IS NOT NULL THEN 1
        ELSE 0
    END AS hired_flag

FROM {{ ref('stg_candidates') }} c
LEFT JOIN {{ ref('fct_funnel') }} f
ON c.candidate_id = f.candidate_id