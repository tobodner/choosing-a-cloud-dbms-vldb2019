--Template 12
set query_group to 'query 12';
set enable_result_cache_for_session=false;
select
	l_shipmode,
	sum(case
		when o_orderpriority = '1-URGENT'
			or o_orderpriority = '2-HIGH'
			then 1
		else 0
	end) as high_line_count,
	sum(case
		when o_orderpriority <> '1-URGENT'
			and o_orderpriority <> '2-HIGH'
			then 1
		else 0
	end) as low_line_count
from
	spectrum1000.orders,
	spectrum1000.lineitem
where
	o_orderkey = l_orderkey
	and l_shipmode in ('RAIL', 'AIR')
	and l_commitdate < l_receiptdate
	and l_shipdate < l_commitdate
	and l_receiptdate >= date '1993-01-01'
	and l_receiptdate < date '1993-01-01' + interval '1 year'
group by
	l_shipmode
order by
	l_shipmode;
