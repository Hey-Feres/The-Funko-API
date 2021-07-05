# frozen_string_literal: true

class Brand < ApplicationRecord
  # Some brand examples: ["Pop! Rides", "Pop!", "Pin", "Pop! Keychain"]

  SEARCHABLE_FIELDS = %w[id name slug]
  SERIALIZABLE_FIELDS = %w[id name slug]

  has_many :items

  validates :name, :slug, presence: true
end
