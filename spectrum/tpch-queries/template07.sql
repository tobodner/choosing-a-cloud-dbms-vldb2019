--Template 7
set query_group to 'query 07';
set enable_result_cache_for_session=false;
select
	supp_nation,
	cust_nation,
	l_year,
	sum(volume) as revenue
from
	(
		select
			n1.n_name as supp_nation,
			n2.n_name as cust_nation,
			extract(year from l_shipdate) as l_year,
			l_extendedprice * (1 - l_discount) as volume
		from
			spectrum1000.supplier,
			spectrum1000.lineitem,
			spectrum1000.orders,
			spectrum1000.customer,
			spectrum1000.nation n1,
			spectrum1000.nation n2
		where
			s_suppkey = l_suppkey
			and o_orderkey = l_orderkey
			and c_custkey = o_custkey
			and s_nationkey = n1.n_nationkey
			and c_nationkey = n2.n_nationkey
			and (
				(n1.n_name = 'JAPAN' and n2.n_name = 'EGYPT')
				or (n1.n_name = 'EGYPT' and n2.n_name = 'JAPAN')
			)
			and l_shipdate between date '1995-01-01' and date '1996-12-31'
	) as shipping
group by
	supp_nation,
	cust_nation,
	l_year
order by
	supp_nation,
	cust_nation,
	l_year;
