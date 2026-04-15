# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authenticate
  include SetCurrentRequestDetails
  include Authorize

  include Breadcrumbs
  include Pagy::Backend

  helper_method :turbo_frame_request?
  helper_method :turbo_native_app?
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
