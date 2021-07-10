# frozen_string_literal: true

module Api::V1
  class LicensesController < ApplicationController
    before_action :set_license, only: %i[show]

    def index
      render json: @scope.with_items, meta: @meta
    end

    def show
      authorize @license
      render json: @license
    end

    def items
      render json: @items, meta: @meta
    end

    private
      def set_license
        @license = License.find_by(slug: params[:id])
      end
  end
end
