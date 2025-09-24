-- Normalização de cliques de marketing
select
  click_id,
  lower(customer_email) as customer_email,
  lower(channel) as channel,
  campaign,
  clicked_at
from {{ ref('raw_marketing_clicks') }}