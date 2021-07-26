# frozen_string_literal: true

module Api::V1
  class CollectionsController < ApplicationController
    skip_before_action :set_index, only: %i[index]
    skip_before_action :set_associated_items, only: %i[items]
    before_action :authenticate_user!
    before_action :set_collection, only: %i[show update destroy items]

    def index
      @collections = current_user.collections.paginate(page, length)
      @meta  = {
        page: page,
        length: length,
        total: current_user.collections.count,
        total_pages: current_user.collections.total_pages(length)
      }
      render json: @collections, include: %i[items], meta: @meta
    end

    def show
      render json: @collection, include: %i[items]
    end

    def create
      @collection = Collection.new(collection_params)
      if @collection.save
        render json: @collection, include: %i[items], status: :created
      else
        render json: @collection.errors, status: :unprocessable_entity
      end
    end

    def update
      if @collection.update(collection_params)
        render json: @collection, include: %i[items]
      else
        render json: @collection.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @collection.destroy
    end

    def items
      @items  = @collection.items.paginate(page, length)
      @meta   = {
        page: page,
        length: length,
        total: @collection.items.count,
        total_pages: @collection.items.total_pages(length)
      }

      render json: @items, meta: @meta
    end

    def lite_items
      @items = current_user.collections.joins(:items).select('items.id')

      render json: @items
    end

    private
      def set_collection
        id = params[:id] || params[:collection_id]
        @collection = Collection.find(id)
      end

      def collection_params
        params.require(:collection).permit(:name, items_ids: [], remove_items_ids: [])
      end
  end
end
