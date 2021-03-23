class Event < ApplicationRecord
  has_many :items
  has_and_belongs_to_many :events

  validates :name, presence: true
end
