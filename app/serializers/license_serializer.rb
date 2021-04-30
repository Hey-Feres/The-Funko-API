# frozen_string_literal: true

#
# License data serialization
class LicenseSerializer < ActiveModel::Serializer
  #
  # Attributes
  #

  attributes License::SERIALIZABLE_FIELDS
end
