# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :user, :app_session, :organization
end
