# frozen_string_literal: true

class Category < ApplicationRecord
  # Some categories examples: ["Other", "Television", "Movies", "Heroes", "Animation"]

  SEARCHABLE_FIELDS = %w[id name slug]
  SERIALIZABLE_FIELDS = %w[id name slug]

  has_many :items

  validates :name, :slug, presence: true
end
