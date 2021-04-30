# frozen_string_literal: true

#
# License model handle the logic of item's licenses
# Some licenses examples: ["Mortal Kombat", "Star Trek", "Marvel", "Naruto", "Disney Animation"]
class License < ApplicationRecord
  #
  # Constants
  #

  SEARCHABLE_FIELDS = %w[id name]
  SERIALIZABLE_FIELDS = %w[id name]

  #
  # Associations
  #

  has_many :items

  #
  # Validations
  #

  validates :name, presence: true
end
