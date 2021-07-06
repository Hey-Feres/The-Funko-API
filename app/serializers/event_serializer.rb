# frozen_string_literal: true

class EventSerializer < ActiveModel::Serializer
  attributes Event::SERIALIZABLE_FIELDS

  def items
    object.items.last(4)
  end
end
