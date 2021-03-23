class Item < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :license, optional: true
  belongs_to :brand, optional: true
  has_and_belongs_to_many :events
  has_and_belongs_to_many :features

  validates :title, :number, presence: true
end
