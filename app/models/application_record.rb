# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  MODELS_WITHOUT_SLUG = %w[WishList Collection DataFetch User]

  include Paginatable
  include Searchable

  before_validation :add_slug

  protected
    def should_add_slug?
      MODELS_WITHOUT_SLUG.exclude?(self.class.to_s)
    end

    def add_slug
      return unless should_add_slug?

      self.slug = self.class == Item ? title.to_slug : name.to_slug
    end
end
