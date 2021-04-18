# frozen_string_literal: true

#
# Application Controller contains all the methdos that will
# be shared between other controllers
class ApplicationController < ActionController::API
  #
  # Modules
  #

  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit
  include ApplicationHelper

  #
  # Callbacks
  #

  before_action :set_index, only: %i[index]

  #
  # Methods
  #

  protected
    #
    # Define model name based on controller
    def scope
      model_from_controller(self.class)
    end

    #
    # Return the page param
    def page
      (params[:page] || 1).to_i
    end

    #
    # Return the length param
    def length
      (params[:length] || 20).to_i
    end

    #
    # Set the index endpoints data
    def set_index
      @scope = scope
      # @scope = @scope.search(search_by, search_for) if should_apply_search?
      @scope = @scope.paginate(page, length)

      render json: @scope, meta: { page: page, total: scope.total_pages(length) }
    end
end
