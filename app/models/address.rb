# frozen_string_literal: true

class Address < ApplicationRecord
  include PermittedAttributes
  attribute :country, default: "KE"
  belongs_to :addressable, polymorphic: true

  validates :line_1, :line_2, :city, :postcode,
    :country, presence: true

  def redacted
    "#{city}, #{postcode}"
  end
end
