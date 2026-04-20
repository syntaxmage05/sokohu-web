# frozen_string_literal: true

class Conversation < ApplicationRecord
  include AccessPolicy

  scope :current_organization, -> {
    where(seller: Current.organization)
      .or(where(buyer: Current.organization))
  }

  scope :for_display, -> {
    joins(:messages)
      .includes(:seller, :listing)
      .order(created_at: :desc)
      .distinct
  }

  belongs_to :listing
  belongs_to :seller, class_name: "Organization"
  belongs_to :buyer, class_name: "Organization"
  has_many :messages, dependent: :destroy

  before_validation :set_seller, unless: :persisted?

  private

    def set_seller
      self.seller = listing.organization
    end
end
