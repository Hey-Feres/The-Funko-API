# frozen_string_literal: true

class Brand < ApplicationRecord
  # Some brand examples: ["Pop! Rides", "Pop!", "Pin", "Pop! Keychain"]

  SEARCHABLE_FIELDS = %w[id name]
  SERIALIZABLE_FIELDS = %w[id name items]

  has_many :items

  validates :name, presence: true

  scope :with_items, -> {
    joins(:items).group('brands.id').having('count(brand_id) > 0')
  }
end
