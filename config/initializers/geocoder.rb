# frozen_string_literal: true

Geocoder.configure(
  lookup: :mapbox,
  api_key: Rails.application.credentials.mapbox[:api_key],
  units: :km,
  timeout: 5
)
