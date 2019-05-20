-- using 1511765941 as a seed to the RNG

select
	sum(l_extendedprice * l_discount) as revenue
from
	lineitem
where
	l_shipdate >= date '1995-01-01'
	and l_shipdate < date '1995-01-01' + interval '1' year
	and l_discount between 0.06 - 0.01001 and 0.06 + 0.01001
	and l_quantity < 24;
