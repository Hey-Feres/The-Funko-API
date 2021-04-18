# frozen_string_literal: true

#
# Api Module
module Api
  #
  # Version 1 Module
  module V1
    #
    # Controller that handle all the features requests
    class FeaturesController < ApplicationController
      #
      # Callbacks
      #

      before_action :set_feature, only: %i[show]

      #
      # Actions
      #

      #
      # GET /features
      def index; end

      #
      # GET /features/1
      def show
        authorize @feature
        render json: @feature
      end

      private
        #
        # Use callbacks to share common setup or constraints between actions.
        def set_feature
          @feature = Feature.find(params[:id])
        end
    end
  end
end
