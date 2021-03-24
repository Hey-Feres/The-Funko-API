# frozen_string_literal: true

#
# Event model handle the logic of events items
# Some events examples: ["Funko Fair 2021", "San Diego Comic Con 2021"]
class Event < ApplicationRecord
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
