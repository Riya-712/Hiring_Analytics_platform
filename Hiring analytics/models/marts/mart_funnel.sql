SELECT
    'Applied' AS stage,
    COUNT(DISTINCT candidate_id) AS candidate_count
FROM {{ ref('stg_events') }}
WHERE stage = 'Applied'

UNION ALL

SELECT
    'Screened',
    COUNT(DISTINCT candidate_id)
FROM {{ ref('stg_events') }}
WHERE stage = 'Screened'

UNION ALL

SELECT
    'Interviewed',
    COUNT(DISTINCT candidate_id)
FROM {{ ref('stg_events') }}
WHERE stage = 'Interviewed'

UNION ALL

SELECT
    'Offered',
    COUNT(DISTINCT candidate_id)
FROM {{ ref('stg_events') }}
WHERE stage = 'Offered'

UNION ALL

SELECT
    'Hired',
    COUNT(DISTINCT candidate_id)
FROM {{ ref('stg_events') }}
WHERE stage = 'Hired'