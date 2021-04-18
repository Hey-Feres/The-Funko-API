# frozen_string_literal: true

#
# Api Module
module Api
  #
  # Version 1 Module
  module V1
    #
    # Controller that handle all the categories requests
    class CategoriesController < ApplicationController
      #
      # Callbacks
      #

      before_action :set_category, only: %i[show]

      #
      # Actions
      #

      #
      # GET /categories
      def index; end

      #
      # GET /categories/1
      def show
        authorize @category
        render json: @category
      end

      private
        #
        # Use callbacks to share common setup or constraints between actions.
        def set_category
          @category = Category.find(params[:id])
        end
    end
  end
end
