# frozen_string_literal: true

#
# Policy that handle the item's permissions
class ItemPolicy < ApplicationPolicy
  #
  # Scope defined for items
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
