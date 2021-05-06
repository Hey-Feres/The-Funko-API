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
  before_action :set_associated_items, only: %i[items]

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
    # Return the search by param
    def search_by
      params[:search_by]
    end

    #
    # Return the search for param
    def search_for
      params[:search_for]
    end

    #
    # Check if search_by and search_for params are present
    def should_apply_search?
      search_by.present? && search_for.present?
    end

    #
    # Set the index endpoints data
    def set_index
      @scope = scope
      @scope = @scope.search(search_by, search_for) if should_apply_search?
      @scope = @scope.paginate(page, length)

      @meta  = {
        page: page,
        length: length,
        total: scope.count,
        total_pages: scope.total_pages(length)
      }

      render json: @scope, meta: @meta
    end

    #
    # Set scope for associated items
    def set_associated_items
      id      = params["#{scope.to_s.downcase}_id".to_sym]
      model   = scope.find(id)
      @items  = model.items.paginate(page, length)
      @meta   = {
        page: page,
        length: length,
        total: model.items.count,
        total_pages: model.items.total_pages(length)
      }
    end
end
