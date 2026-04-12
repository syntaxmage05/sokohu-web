# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include MessageVerifier, HumanEnum

  primary_abstract_class
end
