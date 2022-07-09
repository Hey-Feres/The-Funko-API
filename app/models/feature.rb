# frozen_string_literal: true

class Feature < ApplicationRecord
  # Some features examples: ["Metallic", "Glows in the Dark"]

  SEARCHABLE_FIELDS = %w[id name]
  SERIALIZABLE_FIELDS = %w[id name items]

  has_and_belongs_to_many :items

  validates :name, presence: true

  scope :with_items, -> {
    joins(:items).group('features.id').having('count(feature_id) > 0')
  }
end
