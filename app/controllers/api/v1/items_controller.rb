# frozen_string_literal: true

#
# Api Module
module Api
  #
  # Version 1 Module
  module V1
    #
    # Controller that handle all the items requests
    class ItemsController < ApplicationController
      #
      # Callbacks
      #

      before_action :set_item, only: %i[show]

      #
      # Actions
      #

      #
      # GET /items
      def index
        @items = Item.all

        authorize @items
        render json: @items, include: %i[brand category events features license]
      end

      #
      # GET /items/1
      def show
        authorize @item
        render json: @item, include: %i[brand category events features license]
      end

      private
        #
        # Use callbacks to share common setup or constraints between actions.
        def set_item
          @item = Item.find(params[:id])
        end
    end
  end
end
