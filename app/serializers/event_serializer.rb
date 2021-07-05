# frozen_string_literal: true

class EventSerializer < ActiveModel::Serializer
  attributes Event::SERIALIZABLE_FIELDS
end
