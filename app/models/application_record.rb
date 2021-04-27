# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  #
  # Modules
  #

  include Paginatable
  include Searchable
end
