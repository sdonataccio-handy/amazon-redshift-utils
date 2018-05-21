select
  stvb.slice,
  stvb.blocknum,
  min(case col when 0 then minvalue || ' ~ ' || maxvalue end) as c_custkey,
  min(case col when 1 then minvalue || ' ~ ' || maxvalue end) as c_region,
  min(case col when 2 then minvalue || ' ~ ' || maxvalue end) as c_mktsegment,
  min(case col when 3 then minvalue || ' ~ ' || maxvalue end) as c_date

from
  stv_blocklist stvb

left join
  stv_tbl_perm stvt
on
  stvb.tbl=stvt.id
and
  stvb.slice=stvt.slice

where
  name = 'orders_compound'
and
  col < 10

group by
  name,
  stvb.slice,
  stvb.blocknum

order by
  stvb.slice,
  stvb.blocknum
;
