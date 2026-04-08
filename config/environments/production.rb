require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot for better performance.
  config.eager_load = true

  # Full error reports are disabled in production.
  config.consider_all_requests_local = false

  # Enable fragment caching
  config.action_controller.perform_caching = true

  # Cache static assets
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }

  # Active Storage local service
  config.active_storage.service = :local

  # Force SSL and secure cookies
  config.assume_ssl = true
  config.force_ssl = true

  # Logging
  config.log_tags = [ :request_id ]
  config.logger = ActiveSupport::TaggedLogging.logger(STDOUT)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Prevent health check logs from clogging
  config.silence_healthcheck_path = "/up"

  # Cache and job settings
  config.cache_store = :memory_store
  config.active_job.queue_adapter = :async

  # --- Action Mailer (Gmail SMTP) ---
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false
  config.action_mailer.perform_deliveries = true  # enable email delivery

  # Use ENV variable for your host
  config.action_mailer.default_url_options = {
    host: ENV["DOMAIN_NAME"],   # e.g., "sokohub-k2f4.onrender.com"
    protocol: "https"
  }

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "gmail.com",
    user_name: Rails.application.credentials.dig(:gmail, :username),
    password: Rails.application.credentials.dig(:gmail, :password),
    authentication: :plain,
    enable_starttls_auto: true
  }

  # --- I18n fallback ---
  config.i18n.fallbacks = true

  # --- Active Record ---
  config.active_record.dump_schema_after_migration = false
  config.active_record.attributes_for_inspect = [ :id ]
end
