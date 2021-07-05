# frozen_string_literal: true

class FeatureSerializer < ActiveModel::Serializer
  attributes Feature::SERIALIZABLE_FIELDS
end
