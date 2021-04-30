# frozen_string_literal: true

#
# Feature data serialization
class FeatureSerializer < ActiveModel::Serializer
  #
  # Attributes
  #

  attributes Feature::SERIALIZABLE_FIELDS
end
