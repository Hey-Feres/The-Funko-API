# frozen_string_literal: true

class BrandSerializer < ActiveModel::Serializer
  attributes Brand::SERIALIZABLE_FIELDS
end
