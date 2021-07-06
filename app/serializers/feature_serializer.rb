# frozen_string_literal: true

class FeatureSerializer < ActiveModel::Serializer
  attributes Feature::SERIALIZABLE_FIELDS

  def items
    object.items.last(4)
  end
end
