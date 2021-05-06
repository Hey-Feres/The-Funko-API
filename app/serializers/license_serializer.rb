# frozen_string_literal: true

#
# License data serialization
class LicenseSerializer < ActiveModel::Serializer
  #
  # Attributes
  #

  attributes License::SERIALIZABLE_FIELDS

  #
  # Return the quantity of associated items
  def items_quantity
    object.items.count
  end
end
