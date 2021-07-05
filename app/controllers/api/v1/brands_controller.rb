# frozen_string_literal: true

module Api::V1
  class BrandsController < ApplicationController
    before_action :set_brand, only: %i[show]

    def index; end

    def show
      authorize @brand
      render json: @brand
    end

    def items
      render json: @items, meta: @meta
    end

    private
      def set_brand
        @brand = Brand.find(params[:id])
      end
  end
end