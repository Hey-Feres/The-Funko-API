# frozen_string_literal: true

class LicenseSerializer < ActiveModel::Serializer
  attributes License::SERIALIZABLE_FIELDS

  def items_quantity
    object.items.count
  end

  def items
    object.items.last(4)
  end
end
