# frozen_string_literal: true

#
# Class that handle basic queries
class ApplicationQuery
  #
  # Initialize the class instance
  def initialize(scope: nil, params: [])
    @scope = scope
    @parameters = params
  end

  def valid_params?(param)
    return true unless param['key'].nil? || param['value'].nil? || param['conjunctor'].nil?
  end

  #
  # Include Query
  def query_in(param)
    return unless valid_params?(param)

    parsed_array = param['value'].join(',').prepend('{').concat('}')

    # Attention to the blank space at the end, must be passed
    "#{param['conjunctor']} data.#{param['key']} = ANY('#{parsed_array}') "
  end

  #
  # Not Include Query
  def query_not_in(param)
    return unless valid_params?(param)

    parsed_array = param['value'].join(',').prepend('{').concat('}')

    # Attention to the blank space at the end, must be passed
    "#{param['conjunctor']} NOT (data.#{param['key']} = ANY('#{parsed_array}')) "
  end

  #
  # Equal Query
  def query_equal(param)
    return unless valid_params?(param)

    # Attention to the blank space at the end, must be passed
    "#{param['conjunctor']} data.#{param['key']} = '#{param['value']}' "
  end

  #
  # Not Equal Query
  def query_not_equal(param)
    return unless valid_params?(param)

    # Attention to the blank space at the end, must be passed
    "#{param['conjunctor']} NOT data.#{param['key']} = '#{param['value']}' "
  end

  #
  # Like Query
  def query_like(param)
    return unless valid_params?(param)

    # Attention to the blank space at the end, must be passed
    "#{param['conjunctor']} data.#{param['key']} ILIKE '%#{param['value']}%' "
  end

  #
  # Greather Than Query
  def query_greather_than(param)
    return unless valid_params?(param)

    # Attention to the blank space at the end, must be passed
    "#{param['conjunctor']} data.#{param['key']} > '#{param['value']}' "
  end

  #
  # Greather or Equal Than Query
  def query_greather_or_equal_than(param)
    return unless valid_params?(param)

    # Attention to the blank space at the end, must be passed
    "#{param['conjunctor']} data.#{param['key']} >= '#{param['value']}' "
  end

  #
  # Less Than Query
  def query_less_than(param)
    return unless valid_params?(param)

    # Attention to the blank space at the end, must be passed
    "#{param['conjunctor']} data.#{param['key']} < '#{param['value']}' "
  end

  #
  # Less or Equal Than Query
  def query_less_or_equal_than(param)
    return unless valid_params?(param)

    # Attention to the blank space at the end, must be passed
    "#{param['conjunctor']} data.#{param['key']} <= '#{param['value']}' "
  end

  #
  # Loop all the params to build the complete query
  def build_query
    query = ["SELECT data.* FROM #{@scope.to_s.pluralize.parameterize} data WHERE "]

    @parameters.each do |param|
      case param['operator']
      when 'in'
        partial_query = query_in(param)
      when 'nin'
        partial_query = query_not_in(param)
      when 'eq'
        partial_query = query_equal(param)
      when 'not'
        partial_query = query_not_equal(param)
      when 'like'
        partial_query = query_like(param)
      when 'gt'
        partial_query = query_greather_than(param)
      when 'gte'
        partial_query = query_greather_or_equal_than(param)
      when 'lt'
        partial_query = query_less_than(param)
      when 'lte'
        partial_query = query_less_or_equal_than(param)
      else
        false
      end
      query << partial_query
    end

    query = query.join
  end

  #
  # Runs the query
  def call
    results = ActiveRecord::Base.connection.exec_query(build_query)
  end
end
