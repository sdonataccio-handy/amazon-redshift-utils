select
  userid,
  label,
  stl_query.query,
  trim(database) as database,
  substring (trim(querytxt), 1, 80) as qrytext,
  md5(trim(querytxt)) as qry_md5,
  starttime,
  starttime >=  dateadd(day, -7, current_Date) as last_7_days,
  endtime,
  datediff(seconds, starttime,endtime)::numeric(12,2) as run_seconds,
  aborted,
  alrt.event as alert,
  decode(alrt.event,'Very selective query filter','Filter','Scanned a large number of deleted rows','Deleted','Nested Loop Join in the query plan','Nested Loop','Distributed a large number of rows across the network','Distributed','Broadcasted a large number of rows across the network','Broadcast','Missing query planner statistics','Stats',alrt.event) as event

from
  stl_query

left outer join
  (select
    query,
    trim(split_part(event,':',1)) as event
  from
    STL_ALERT_EVENT_LOG
  where
    event_time >=  dateadd(day, -30, current_Date)
  group by
    query,
    trim(split_part(event,':',1)) ) as alrt
on
  alrt.query = stl_query.query

where
  userid <> 1
and
  starttime >=  dateadd(day, -30, current_Date)
