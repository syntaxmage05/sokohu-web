# frozen_string_literal: true

class Address < ApplicationRecord
  include PermittedAttributes

  attribute :country, default: "Kenya"

  belongs_to :addressable, polymorphic: true

  validates :line_1, :city, :postcode, :country, presence: true

  geocoded_by :redacted
  after_validation :geocode, if: :address_changed?

  def redacted
    [line_1, city, postcode, country].compact.join(", ")
  end

  def address_changed?
    will_save_change_to_line_1? ||
    will_save_change_to_city? ||
    will_save_change_to_postcode?
  end
end
