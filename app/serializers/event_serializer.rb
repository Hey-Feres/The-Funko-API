# frozen_string_literal: true

#
# Event data serialization
class EventSerializer < ActiveModel::Serializer
  #
  # Attributes
  #

  attributes Event::SERIALIZABLE_FIELDS
end
