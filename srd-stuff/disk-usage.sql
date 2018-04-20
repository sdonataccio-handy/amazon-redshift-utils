select
  cast(sum(used) as float)/sum(capacity)*100.0 as usage_percentage,
  sum(capacity)/1024 as capacity_gbytes,
  sum(used)/1024 as used_gbytes,
  (sum(capacity) - sum(used))/1024 as free_gbytes
from
  stv_partitions where part_begin=0;
