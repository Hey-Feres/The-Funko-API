# frozen_string_literal: true

#
# Api Module
module Api
  #
  # Version 1 Module
  module V1
    #
    # Controller that handle all the licenses requests
    class LicensesController < ApplicationController
      #
      # Callbacks
      #

      before_action :set_license, only: %i[show]

      #
      # Actions
      #

      #
      # GET /licenses
      def index; end

      #
      # GET /licenses/1
      def show
        authorize @license
        render json: @license
      end

      #
      # GET /licenses/1/items
      def items
        render json: @items, meta: @meta
      end

      private
        #
        # Use callbacks to share common setup or constraints between actions.
        def set_license
          @license = License.find(params[:id])
        end
    end
  end
end
