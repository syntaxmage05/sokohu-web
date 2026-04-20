# frozen_string_literal: true

class Message < ApplicationRecord
  scope :for_display, -> {
    includes(:from, :sender)
      .where.not(created_at: nil)
      .order(created_at: :asc)
  }
  belongs_to :conversation
  belongs_to :from, class_name: "Organization"
  belongs_to :sender, class_name: "User", optional: true
  validates :body, presence: true
end
