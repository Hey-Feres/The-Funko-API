# frozen_string_literal: true

class EventSerializer < ActiveModel::Serializer
  attributes Event::SERIALIZABLE_FIELDS

  def items
    object.items.first(6)
  end
end
