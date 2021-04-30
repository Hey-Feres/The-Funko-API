# frozen_string_literal: true

#
# Item data serialization
class ItemSerializer < ActiveModel::Serializer
  #
  # Attributes
  #

  attributes Item::SERIALIZABLE_FIELDS

  #
  # Methods
  #

  #
  # Associated category
  def category; object.category&.name end

  #
  # Associated license
  def license; object.license&.name end

  #
  # Associated brand
  def brand; object.brand&.name end

  #
  # Associated events
  def events; object.events&.map(&:name) end

  #
  # Associated features
  def features; object.features&.map(&:name) end
end
