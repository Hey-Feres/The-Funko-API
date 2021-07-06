# frozen_string_literal: true

class BrandSerializer < ActiveModel::Serializer
  attributes Brand::SERIALIZABLE_FIELDS

  def items
    object.items.last(4)
  end
end
