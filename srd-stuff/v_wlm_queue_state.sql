
--DROP VIEW admin.v_wlm_queue_state;

CREATE OR REPLACE VIEW admin.v_wlm_queue_state
AS
SELECT
  (config.service_class-5) as queue,
    trim (class.condition) as description,
    config.num_query_tasks as slots,
    config.query_working_mem as mem,
    config.max_execution_time as max_time,
    config.user_group_wild_card as "user_*",
    config.query_group_wild_card as "query_*",
    state.num_queued_queries queued,
    state.num_executing_queries executing,
    state.num_executed_queries executed
FROM
  STV_WLM_CLASSIFICATION_CONFIG class,
  STV_WLM_SERVICE_CLASS_CONFIG config,
  STV_WLM_SERVICE_CLASS_STATE state
where
  class.action_service_class = config.service_class
and
  class.action_service_class = state.service_class
and
  config.service_class > 4
order by
  config.service_class;
