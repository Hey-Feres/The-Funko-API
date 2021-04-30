# frozen_string_literal: true

#
# Category data serialization
class CategorySerializer < ActiveModel::Serializer
  #
  # Attributes
  #

  attributes Category::SERIALIZABLE_FIELDS
end
