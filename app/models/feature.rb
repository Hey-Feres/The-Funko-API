# frozen_string_literal: true

#
# Feature model handle the logic of item's features
# Some features examples: ["Metallic", "Glows in the Dark"]
class Feature < ApplicationRecord
  #
  # Constants
  #

  SEARCHABLE_FIELDS = %w[id name]

  #
  # Associations
  #

  has_and_belongs_to_many :items

  #
  # Validations
  #

  validates :name, presence: true
end
