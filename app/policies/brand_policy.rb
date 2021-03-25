# frozen_string_literal: true

#
# Policy that handle the brand's permissions
class BrandPolicy < ApplicationPolicy
  #
  # Scope defined for brands
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
