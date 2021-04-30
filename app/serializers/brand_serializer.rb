# frozen_string_literal: true

#
# Brand data serialization
class BrandSerializer < ActiveModel::Serializer
  #
  # Attributes
  #

  attributes Brand::SERIALIZABLE_FIELDS
end
