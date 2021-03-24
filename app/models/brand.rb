# frozen_string_literal: true

#
# Brand model handle the logic of item's brand
# Some brand examples: ["Pop! Rides", "Pop!", "Pin", "Pop! Keychain"]
class Brand < ApplicationRecord
  #
  # Associations
  #

  has_many :items

  #
  # Validations
  #

  validates :name, presence: true
end
