# frozen_string_literal: true

module Api::V1
  class CategoriesController < ApplicationController
    before_action :set_category, only: %i[show]

    def index; end

    def show
      authorize @category
      render json: @category
    end

    def items
      render json: @items, meta: @meta
    end

    private
      def set_category
        @category = Category.find(params[:id])
      end
  end
end
