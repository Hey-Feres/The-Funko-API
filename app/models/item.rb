# frozen_string_literal: true

class Item < ApplicationRecord
  SEARCHABLE_FIELDS   = %w[
    id number title form_factor features
    inner_case_count master_case_quantity
    status license_id category_id brand_id
  ]

  SERIALIZABLE_FIELDS = %w[
    id number title form_factor features
    inner_case_count master_case_quantity
    status category license brand events
    image_url features
  ]

  belongs_to :category, optional: true, counter_cache: true
  belongs_to :license, optional: true, counter_cache: true
  belongs_to :brand, optional: true, counter_cache: true

  has_and_belongs_to_many :events
  has_and_belongs_to_many :features

  has_and_belongs_to_many :collections, dependent: :destroy
  has_and_belongs_to_many :wish_lists, dependent: :destroy

  has_many :users_collections, through: :collections, source: :user
  has_many :users_wish_lists,  through: :wish_lists, source: :user

  validates :title, :number, presence: true
end