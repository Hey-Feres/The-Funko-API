# frozen_string_literal: true

class CategorySerializer < ActiveModel::Serializer
  attributes Category::SERIALIZABLE_FIELDS

  def items
    object.items.last(4)
  end
end
