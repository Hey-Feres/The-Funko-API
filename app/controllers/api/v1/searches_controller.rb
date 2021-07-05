# frozen_string_literal: true

module Api::V1
  class SearchesController < ApplicationController
    skip_before_action :set_index
    before_action :filter_search_params

    OPERATOR   = %w[in nin eq not like gt gte lt lte]
    CONJUNCTOR = ['and', 'or', '']


    def index
      @query = ApplicationQuery.new(scope: filter_params[:scope].titleize.constantize, params: filter_params[:search]).call

      render json: @query
    end

    private
      def filter_params
        params.permit(:scope, search: [ [ :operator, :conjunctor, :include, :key, :value, value: [] ] ])
      end

      def valid_searchable_attributes
        params[:scope].titleize.constantize::SEARCHABLE_FIELDS
      end

      def query_params_valid?(param)
        return true if OPERATOR.include?(param[:operator]) &&
                       CONJUNCTOR.include?(param[:conjunctor]) &&
                       valid_searchable_attributes.include?(param[:key])
      end

      def filter_search_params
        params[:search].each do |param|
          raise 'Invalid search parameter' unless query_params_valid?(param)
        end
      rescue => error
        error
      end
  end
end
