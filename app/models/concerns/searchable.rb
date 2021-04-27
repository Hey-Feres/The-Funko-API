module Searchable
  extend ActiveSupport::Concern

  included do
    scope :search, -> (search_by, search_for) do
      self.where("#{search_by} ILIKE ?", "%#{search_for}%")
    end
  end
end