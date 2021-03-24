# frozen_string_literal: true

#
# Item model handle the logic of funko's items
class Item < ApplicationRecord
  #
  # Constants
  #

  SEARCHABLE_FIELDS = %w[id number title form_factor features inner_case_count master_case_quantity status]

  #
  # Associations
  #

  belongs_to :category, optional: true
  belongs_to :license, optional: true
  belongs_to :brand, optional: true
  has_and_belongs_to_many :events
  has_and_belongs_to_many :features
  has_and_belongs_to_many :collections, dependent: :destroy
  has_and_belongs_to_many :wish_lists, dependent: :destroy

  #
  # Validations
  #

  validates :title, :number, presence: true
end