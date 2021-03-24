# frozen_string_literal: true

#
# Collection model handle the logic of user's collections
class Collection < ApplicationRecord
  #
  # Assocations
  #

  has_and_belongs_to_many :items, dependent: :destroy

  #
  # Validations
  #

  validates :name, presence: true
end
