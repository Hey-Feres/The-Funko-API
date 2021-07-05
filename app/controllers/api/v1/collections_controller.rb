# frozen_string_literal: true

module Api::V1
  class CollectionsController < ApplicationController
    skip_before_action :set_index, only: %i[index]
    before_action :authenticate_user!
    before_action :set_collection, only: %i[show update destroy]

    def index
      @collections = current_user.collections.paginate(page, length)
      @meta  = {
        page: page,
        length: length,
        total: current_user.collections.count,
        total_pages: current_user.collections.total_pages(length)
      }
      render json: @collections, meta: @meta
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

    private
      def set_collection
        @collection = Collection.find(params[:id])
      end

      def collection_params
        params.require(:collection).permit(:name, items_ids: [], remove_items_ids: [])
      end
  end
end
