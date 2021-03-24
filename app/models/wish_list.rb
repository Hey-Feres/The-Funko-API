# frozen_string_literal: true

#
# Collection model handle the logic of user's wish lists
class WishList < ApplicationRecord
  #
  # Virtual Attributes
  #

  attr_accessor :items_ids, :remove_items_ids

  #
  # Assocations
  #

  has_and_belongs_to_many :items, dependent: :destroy

  #
  # Validations
  #

  validates :name, presence: true

  #
  # Callbacks
  #

  before_validation :set_items, :remove_items

  private
    #
    # Find the item's records and set to the collection
    def set_items
      return if items_ids.blank?

      items_ids.each do |id|
        item = Item.find(id)
        items << item if items.map(&:id).exclude?(id)
      end
    end

    #
    # Find the item's records and remove from the collection
    def remove_items
      return if remove_items_ids.blank?

      remove_items_ids.uniq.each do |id|
        item = Item.find(id)

        items.delete(item) if items.map(&:id).include?(id)
      end
    end
end
