# frozen_string_literal: true

class License < ApplicationRecord
  # Some licenses examples: ["Mortal Kombat", "Star Trek", "Marvel", "Naruto", "Disney Animation"]

  SEARCHABLE_FIELDS = %w[id name slug]
  SERIALIZABLE_FIELDS = %w[id name slug items_quantity]

  has_many :items

  validates :name, :slug, presence: true
end
