# frozen_string_literal: true

class ApplicationQuery
  def initialize(scope: nil, params: [])
    @scope = scope
    @parameters = params
    @query = []
  end

  def valid_params?(param)
    return true unless param['key'].nil? || param['value'].nil? || param['conjunctor'].nil?
  end

  def query_in(param)
    return unless valid_params?(param)

    parsed_array = param['value'].join(',').prepend('{').concat('}')

    # Attention to the blank space at the end, must be passed
    "#{param['conjunctor']} data.#{param['key']} = ANY('#{parsed_array}') "
  end

  def query_not_in(param)
    return unless valid_params?(param)

    parsed_array = param['value'].join(',').prepend('{').concat('}')

    # Attention to the blank space at the end, must be passed
    "#{param['conjunctor']} NOT (data.#{param['key']} = ANY('#{parsed_array}')) "
  end

  def query_equal(param)
    return unless valid_params?(param)

    # Attention to the blank space at the end, must be passed
    "#{param['conjunctor']} data.#{param['key']} = '#{param['value']}' "
  end

  def query_not_equal(param)
    return unless valid_params?(param)

    # Attention to the blank space at the end, must be passed
    "#{param['conjunctor']} NOT data.#{param['key']} = '#{param['value']}' "
  end

  def query_like(param)
    return unless valid_params?(param)

    key = param['key'].include?('.') ? param['key'] : "data.#{param['key']}"

    # Attention to the blank space at the end, must be passed
    "#{param['conjunctor']} #{key} ILIKE '%#{param['value']}%' "
  end

  def query_greather_than(param)
    return unless valid_params?(param)

    # Attention to the blank space at the end, must be passed
    "#{param['conjunctor']} data.#{param['key']} > '#{param['value']}' "
  end

  def query_greather_or_equal_than(param)
    return unless valid_params?(param)

    # Attention to the blank space at the end, must be passed
    "#{param['conjunctor']} data.#{param['key']} >= '#{param['value']}' "
  end

  def query_less_than(param)
    return unless valid_params?(param)

    # Attention to the blank space at the end, must be passed
    "#{param['conjunctor']} data.#{param['key']} < '#{param['value']}' "
  end

  def query_less_or_equal_than(param)
    return unless valid_params?(param)

    # Attention to the blank space at the end, must be passed
    "#{param['conjunctor']} data.#{param['key']} <= '#{param['value']}' "
  end

  def scope_associations(assocation)
    return if assocation.blank?

    case assocation
    when :belongs_to
      @scope.reflect_on_all_associations(:belongs_to).map(&:name).map(&:to_s)
    when :has_one
      @scope.reflect_on_all_associations(:has_one).map(&:name).map(&:to_s)
    when :has_many
      @scope.reflect_on_all_associations(:has_many).map(&:name).map(&:to_s)
    when :has_and_belongs_to_many
      @scope.reflect_on_all_associations(:has_and_belongs_to_many).map(&:name).map(&:to_s)
    else
      []
    end
  end

  def valid_table_joinment?(param)
    return true if scope_associations(:belongs_to).include?(param) ||
                   scope_associations(:has_one).include?(param) ||
                   scope_associations(:has_many).include?(param) ||
                   scope_associations(:has_and_belongs_to_many).include?(param)
  end

  def build_joinments
    @parameters.each do |param|
      return unless valid_table_joinment?(param['include'])
      binding.pry
      association = param['include']

      # Join Statement in case association is polymorphic
      if scope_associations(:has_and_belongs_to_many).include?(association)
        # WORKING HERE
        @query << "LEFT JOIN #{association.pluralize} #{association.singularize} ON (data.id = #{association.singularize}.data_id) "

        # Ex:
        # @query << "LEFT JOIN events_items event_item ON (data.id = event_item.item.id) "
      # Join Statement in case association is belongs to
      elsif scope_associations(:belongs_to).include?(association)
        @query << "LEFT JOIN #{association.pluralize} #{association.singularize} ON (data.#{association.singularize}_id = #{association.singularize}.id) "
      # Join Statement in case association is has many or has one
      else
        @query << "LEFT JOIN #{association.pluralize} #{association.singularize} ON (data.id = #{association.singularize}.data_id) "
      end
    end
  end

  def build_wheres
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
      @query << partial_query
    end
  end

  def build_query
    @query << "SELECT data.* FROM #{@scope.to_s.pluralize.parameterize} data "

    build_joinments

    @query << "WHERE "

    build_wheres

    @query = @query.join
  end

  def call
    results = ActiveRecord::Base.connection.exec_query(build_query)
  end
end
