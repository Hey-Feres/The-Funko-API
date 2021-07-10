# frozen_string_literal: true

class CategorySerializer < ActiveModel::Serializer
  attributes Category::SERIALIZABLE_FIELDS

  def items
    object.items.first(6)
  end
end
