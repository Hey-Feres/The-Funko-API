# frozen_string_literal: true

class FeatureSerializer < ActiveModel::Serializer
  attributes Feature::SERIALIZABLE_FIELDS

  def items
    object.items.first(6)
  end
end
