with first_touch as (
    select source, sum(credit) as first_touch_credit
    from {{ ref('mart_attribution_first_touch') }}
    group by source
),
last_touch as (
    select source, sum(credit) as last_touch_credit
    from {{ ref('mart_attribution_last_touch') }}
    group by source
),
linear as (
    select source, sum(credit) as linear_credit
    from {{ ref('mart_attribution_linear') }}
    group by source
),
time_decay as (
    select source, sum(credit) as time_decay_credit
    from {{ ref('mart_attribution_time_decay') }}
    group by source
)

select
    coalesce(f.source, l.source, li.source, t.source) as source,
    coalesce(first_touch_credit, 0) as first_touch_credit,
    coalesce(last_touch_credit, 0) as last_touch_credit,
    coalesce(linear_credit, 0) as linear_credit,
    coalesce(time_decay_credit, 0) as time_decay_credit
from first_touch f
full outer join last_touch l on f.source = l.source
full outer join linear li on coalesce(f.source, l.source) = li.source
full outer join time_decay t on coalesce(f.source, l.source, li.source) = t.source