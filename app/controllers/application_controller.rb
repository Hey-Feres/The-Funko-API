# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit
  include ApplicationHelper

  before_action :set_index, only: %i[index]
  before_action :set_associated_items, only: %i[items]
  after_action :add_headers

  protected
    def scope
      model_from_controller(self.class)
    end

    def page
      (params[:page] || 1).to_i
    end

    def length
      (params[:length] || 20).to_i
    end

    def search_by
      params[:search_by]
    end

    def search_for
      params[:search_for]
    end

    def should_apply_search?
      search_by.present? && search_for.present?
    end

    def query
      return scope unless params[:query]

      q = params[:query].split("=")
      scope.ransack({ q[0].to_sym => q[1] }).result(distinct: true)
    end

    def set_index
      q = query

      @scope = q.order(created_at: :desc).paginate(page, length) 

      @meta  = {
        page: page,
        length: length,
        total: q.count,
        total_pages: q.total_pages(length)
      }
    end

    def set_associated_items
      slug    = params["#{scope.to_s.downcase}_id".to_sym]
      model   = scope.find_by(slug: slug)
      @items  = model.items.paginate(page, length)
      @meta   = {
        page: page,
        length: length,
        total: model.items.count,
        total_pages: model.items.total_pages(length)
      }
    end

    def add_headers
      return unless current_user.present?

      collections = current_user.collections
      wish_lists  = current_user.wish_lists

      response.headers['CURRENT-USER-DEFAULT-COLLECTION-ID'] = collections.first.id
      response.headers['CURRENT-USER-DEFAULT-WISH-LIST-ID']  = wish_lists.first.id
      response.headers['CURRENT-USER-WISH-LISTS-ITEMS-IDS']  = wish_lists.joins(:items).select('items.id').map(&:id).uniq
      response.headers['CURRENT-USER-COLLECTIONS-ITEMS-IDS'] = collections.joins(:items).select('items.id').map(&:id).uniq
    end
end
