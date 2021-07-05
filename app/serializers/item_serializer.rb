# frozen_string_literal: true

class ItemSerializer < ActiveModel::Serializer
  attributes Item::SERIALIZABLE_FIELDS

  def category; object.category&.name end

  def license; object.license&.name end

  def brand; object.brand&.name end

  def events; object.events&.map(&:name) end

  def features; object.features&.map(&:name) end
end
