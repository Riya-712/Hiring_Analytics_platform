select
    source,
    sum(credit) as attributed_hires
from {{ ref('mart_attribution_linear') }}
group by source
order by attributed_hires desc