# frozen_string_literal: true

#
# Api Module
module Api
  #
  # Version 1 Module
  module V1
    #
    # Controller that handle all the events requests
    class EventsController < ApplicationController
      #
      # Callbacks
      #

      before_action :set_event, only: %i[show]

      #
      # Actions
      #

      #
      # GET /events
      def index
        @events = Event.all

        render json: @events
      end

      #
      # GET /events/1
      def show
        render json: @event
      end

      private
        #
        # Use callbacks to share common setup or constraints between actions.
        def set_event
          @event = Event.find(params[:id])
        end
    end
  end
end
