# frozen_string_literal: true

class Brand < ApplicationRecord
  # Some brand examples: ["Pop! Rides", "Pop!", "Pin", "Pop! Keychain"]

  SEARCHABLE_FIELDS = %w[id name slug]
  SERIALIZABLE_FIELDS = %w[id name slug items]

  has_many :items

  validates :name, :slug, presence: true

  scope :with_items, -> {
    joins(:items).group('brands.id').having('count(brand_id) > 0')
  }
end
