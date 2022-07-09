# frozen_string_literal: true

class Category < ApplicationRecord
  # Some categories examples: ["Other", "Television", "Movies", "Heroes", "Animation"]

  SEARCHABLE_FIELDS = %w[id name]
  SERIALIZABLE_FIELDS = %w[id name items]

  has_many :items

  validates :name, :slug, presence: true

  scope :with_items, -> {
    joins(:items).group('categories.id').having('count(category_id) > 0')
  }
end
