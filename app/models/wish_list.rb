# frozen_string_literal: true

class WishList < ApplicationRecord
  attr_accessor :items_ids, :remove_items_ids

  belongs_to :user, dependent: :destroy
  has_and_belongs_to_many :items, dependent: :destroy

  validates :name, presence: true

  before_validation :set_items, :remove_items

  private
    def set_items
      return if items_ids.blank?

      items_ids.each do |id|
        id = id.to_i

        item = Item.find(id)
        items << item if items.map(&:id).exclude?(id)
      end
    end

    def remove_items
      return if remove_items_ids.blank?

      remove_items_ids.uniq.each do |id|
        id = id.to_i

        item = Item.find(id)
        items.delete(item) if items.map(&:id).include?(id)
      end
    end
end
