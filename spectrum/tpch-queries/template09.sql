--Template 9
set query_group to 'query 09';
set enable_result_cache_for_session=false;
select
				nation,
				o_year,
				sum(amount) as sum_profit
from (
				select
								n_name as nation,
								extract(year from o_orderdate) as o_year,
								l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity as amount
				from
								spectrum1000.part,
								spectrum1000.supplier,
								spectrum1000.lineitem,
								spectrum1000.partsupp,
								spectrum1000.orders,
								spectrum1000.nation
				where
								s_suppkey = l_suppkey
								and ps_suppkey = l_suppkey
								and ps_partkey = l_partkey
								and p_partkey = l_partkey
								and o_orderkey = l_orderkey
								and s_nationkey = n_nationkey
								and p_name like '%cyan%'
				) as profit
group by
				nation,
				o_year
order by
				nation,
				o_year desc;

