# frozen_string_literal: true

class LicenseSerializer < ActiveModel::Serializer
  attributes License::SERIALIZABLE_FIELDS

  def items_quantity
    object.items.count
  end
end
