# frozen_string_literal: true

#
# Category model handle the logic of item's categories
# Some categories examples: ["Other", "Television", "Movies", "Heroes", "Animation"]
class Category < ApplicationRecord
  #
  # Constants
  #

  SEARCHABLE_FIELDS = %w[id name]

  #
  # Associations
  #

  has_many :items

  #
  # Validations
  #

  validates :name, presence: true
end
