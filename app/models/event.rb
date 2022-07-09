# frozen_string_literal: true

class Event < ApplicationRecord
  # Some events examples: ["Funko Fair 2021", "San Diego Comic Con 2021"]

  SEARCHABLE_FIELDS = %w[id name]
  SERIALIZABLE_FIELDS = %w[id name items]

  has_and_belongs_to_many :items

  validates :name, presence: true
end
