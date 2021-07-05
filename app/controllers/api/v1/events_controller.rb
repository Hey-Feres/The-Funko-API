# frozen_string_literal: true

module Api::V1
  class EventsController < ApplicationController
    before_action :set_event, only: %i[show]

    def index; end

    def show
      authorize @event
      render json: @event
    end

    def items
      render json: @items, meta: @meta
    end

    private
      def set_event
        @event = Event.find(params[:id])
      end
  end
end
