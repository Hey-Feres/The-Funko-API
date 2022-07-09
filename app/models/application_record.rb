# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include ApplicationHelper

  self.abstract_class = true

  MODELS_WITHOUT_SLUG = %w[WishList Collection DataFetch User]

  include Paginatable

  before_validation :add_slug

  protected
    def should_add_slug?
      MODELS_WITHOUT_SLUG.exclude?(self.class.to_s)
    end

    def add_slug
      return unless should_add_slug?

      if self.class == Item
        slug = "#{title.to_slug}_#{generate_slug_number}"
        self.slug = slug
      else
        slug = "#{name.to_slug}_#{generate_slug_number}"
        self.slug = slug
      end
    end
end
