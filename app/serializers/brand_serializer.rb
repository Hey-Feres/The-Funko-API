# frozen_string_literal: true

class BrandSerializer < ActiveModel::Serializer
  attributes Brand::SERIALIZABLE_FIELDS

  def items
    object.items.first(6)
  end
end
