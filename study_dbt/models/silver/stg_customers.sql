with base as (
	select 
		c.customer_id, 
		c.full_name,		
		lower(c.email) as email,
		c.phone, 
		c.zipcode	
	from {{ ref('raw_customers') }} as c 
), geo as (
	select 
		geo.zipcode,
		geo.city,
		geo.state,
		geo.region
	from {{ ref('raw_geo_zipcode') }} as geo 
)
select
	base.customer_id,
	base.full_name,
	base.email,
	base.phone,
	geo.zipcode,
	geo.city,
	geo.state,
	geo.region
from base join geo 
	on base.zipcode = geo.zipcode
 