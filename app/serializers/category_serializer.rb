# frozen_string_literal: true

class CategorySerializer < ActiveModel::Serializer
  attributes Category::SERIALIZABLE_FIELDS
end
