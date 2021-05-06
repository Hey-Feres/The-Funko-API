# frozen_string_literal: true

#
# Api Module
module Api
  #
  # Version 1 Module
  module V1
    #
    # Controller that handle all the brands requests
    class BrandsController < ApplicationController
      #
      # Callbacks
      #

      before_action :set_brand, only: %i[show]

      #
      # Actions
      #

      #
      # GET /brands
      def index; end

      #
      # GET /brands/1
      def show
        authorize @brand
        render json: @brand
      end

      #
      # GET /brands/1/items
      def items
        render json: @items, meta: @meta
      end

      private
        #
        # Use callbacks to share common setup or constraints between actions.
        def set_brand
          @brand = Brand.find(params[:id])
        end
    end
  end
end