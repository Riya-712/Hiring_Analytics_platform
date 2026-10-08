SELECT
    candidate_id,

    MAX(CASE WHEN stage='Applied' THEN event_date END) AS applied_date,
    MAX(CASE WHEN stage='Screened' THEN event_date END) AS screened_date,
    MAX(CASE WHEN stage='Interviewed' THEN event_date END) AS interview_date,
    MAX(CASE WHEN stage='Offered' THEN event_date END) AS offer_date,
    MAX(CASE WHEN stage='Hired' THEN event_date END) AS hired_date

FROM {{ ref('stg_events') }}
GROUP BY candidate_id