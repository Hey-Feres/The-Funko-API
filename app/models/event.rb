# frozen_string_literal: true

class Event < ApplicationRecord
  # Some events examples: ["Funko Fair 2021", "San Diego Comic Con 2021"]

  SEARCHABLE_FIELDS = %w[id name slug]
  SERIALIZABLE_FIELDS = %w[id name slug]

  has_and_belongs_to_many :items

  validates :name, :slug, presence: true
end
