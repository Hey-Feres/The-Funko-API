# frozen_string_literal: true

module Api::V1
  class ItemsController < ApplicationController
    before_action :set_item, only: %i[show]

    def index
      byebug
      render json: @scope, meta: @meta
    end

    def show
      authorize @item
      render json: @item
    end

    private
      def set_item
        @item = Item.find(params[:id])
      end
  end
end
