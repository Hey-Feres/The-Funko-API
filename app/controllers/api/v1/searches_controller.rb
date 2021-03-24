# frozen_string_literal: true

#
# Api Module
module Api
  #
  # Version 1 Module
  module V1
    #
    # Controller that handle all the licenses requests
    class SearchesController < ApplicationController
      before_action :filter_search_params

      #
      # Constants
      #

      OPERATOR   = %w[in nin eq not like gt gte lt lte]
      CONJUNCTOR = ['and', 'or', '']

      #
      # Actions
      #

      #
      # POST /search
      def index
        @query = ApplicationQuery.new(scope: filter_params[:scope].titleize.constantize, params: filter_params[:search]).call

        render json: @query
      end

      private
        #
        # Filter the received params
        def filter_params
          params.permit(:scope, search: [ [ :operator, :conjunctor, :key, :value, value: [] ] ])
        end

        #
        # Check if the received attributes to be searched is valid
        def valid_searchable_attributes
          params[:scope].titleize.constantize::SEARCHABLE_FIELDS
        end

        #
        # Conditional that check if the received params match with the validations
        def query_params_valid?(param)
          return true if OPERATOR.include?(param[:operator]) &&
                         CONJUNCTOR.include?(param[:conjunctor]) &&
                         valid_searchable_attributes.include?(param[:key])
        end

        #
        # Filter the received search params
        def filter_search_params
          params[:search].each do |param|
            raise 'Invalid search parameter' unless query_params_valid?(param)
          end
        rescue => error
          error
        end
    end
  end
end
