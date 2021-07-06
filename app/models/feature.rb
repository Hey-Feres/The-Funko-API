# frozen_string_literal: true

class Feature < ApplicationRecord
  # Some features examples: ["Metallic", "Glows in the Dark"]

  SEARCHABLE_FIELDS = %w[id name slug]
  SERIALIZABLE_FIELDS = %w[id name slug items]

  has_and_belongs_to_many :items

  validates :name, :slug, presence: true
end
