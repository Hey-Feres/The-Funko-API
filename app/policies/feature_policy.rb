# frozen_string_literal: true

#
# Policy that handle the feature's permissions
class FeaturePolicy < ApplicationPolicy
  #
  # Scope defined for features
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
