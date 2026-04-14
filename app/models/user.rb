# frozen_string_literal: true

class User < ApplicationRecord
  include Authentication, PasswordReset
  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships
  has_and_belongs_to_many :saved_listings,
    join_table: "saved_listings",
    class_name: "Listing"

  validates :name, presence: true
  validates :email,
    format: { with: URI::MailTo::EMAIL_REGEXP },
    uniqueness: { case_sensitive: false }

  before_validation :strip_extra_spaces

  private

    def strip_extra_spaces
      self.name = self.name&.strip
      self.email = self.email&.strip
    end
end
