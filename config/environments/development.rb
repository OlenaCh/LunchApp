Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.digest = true
  config.assets.raise_runtime_errors = true
  
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.host = 'localhost:3000'
end

Flog.configure do |config|
  # If this value is true, not format on cached query
  config.ignore_cached_query = false
  # If query duration is under this value, not format
  config.query_duration_threshold = 2.0
  # If key count of parameters is under this value, not format
  config.params_key_count_threshold = 2
  # If this value is true, nested Hash parameter is formatted coercively in any situation
  config.force_on_nested_params = false
end