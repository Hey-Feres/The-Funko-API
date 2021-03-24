# frozen_string_literal: true

#
# Category model handle the logic of item's categories
# Some categories examples: ["Other", "Television", "Movies", "Heroes", "Animation"]
class Category < ApplicationRecord
  #
  # Associations
  #

  has_many :items

  #
  # Validations
  #

  validates :name, presence: true
end
