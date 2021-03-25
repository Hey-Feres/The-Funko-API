# frozen_string_literal: true

#
# Policy that handle the category's permissions
class CategoryPolicy < ApplicationPolicy
  #
  # Scope defined for categories
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  #
  # Methods
  #

  #
  # Authorization for index action
  def index?
    true
  end

  #
  # Authorization for show action
  def show?
    true
  end
end
