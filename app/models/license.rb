# frozen_string_literal: true

class License < ApplicationRecord
  # Some licenses examples: ["Mortal Kombat", "Star Trek", "Marvel", "Naruto", "Disney Animation"]

  SEARCHABLE_FIELDS = %w[id name]
  SERIALIZABLE_FIELDS = %w[id name items_quantity items]

  has_many :items

  validates :name, presence: true

  scope :with_items, -> {
    joins(:items).group('licenses.id').having('count(license_id) > 0')
  }
end
