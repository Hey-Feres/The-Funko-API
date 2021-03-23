class Brand < ApplicationRecord
  has_many :brand

  validates :name, presence: true
end
