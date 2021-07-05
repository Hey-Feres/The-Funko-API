# frozen_string_literal: true

module Api::V1
  class FeaturesController < ApplicationController
    before_action :set_feature, only: %i[show]

    def index; end

    def show
      authorize @feature
      render json: @feature
    end

    def items
      render json: @items, meta: @meta
    end

    private
      def set_feature
        @feature = Feature.find(params[:id])
      end
  end
end
