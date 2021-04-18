module Paginatable
  extend ActiveSupport::Concern

  MAX_PER_PAGE = 20
  DEFAULT_PAGE = 1

  included do
    scope :paginate, -> (page, length) do
      page = page.present? && page > 0 ? page : DEFAULT_PAGE
      length = length.present? && length > 0 ? length : MAX_PER_PAGE
      starts_at = (page - 1) * length
      limit(length).offset(starts_at)
    end

    def self.total_pages(length)
      if length.present?
        (self.all.count.to_f / length).ceil
      else
        (self.all.count.to_f / MAX_PER_PAGE).ceil
      end
    end

    def self.total_count
      self.all.count
    end
  end
end