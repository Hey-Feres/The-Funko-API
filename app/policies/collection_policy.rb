# frozen_string_literal: true

#
# Policy that handle the collection's permissions
class CollectionPolicy < ApplicationPolicy
  #
  # Scope defined for collections
  class Scope < Scope
    def resolve
      scope.where(user_id: user&.id)
    end
  end

  #
  # Methods
  #

  #
  # Authorization for index action
  def index?
    user_present?
  end

  #
  # Authorization for show action
  def show?
    collection_belongs_to_user?
  end

  #
  # Authorization for create action
  def create?
    user_present?
  end

  #
  # Authorization for update action
  def update?
    collection_belongs_to_user?
  end

  #
  # Authorization for destroy action
  def destroy?
    collection_belongs_to_user?
  end

  private
    #
    # Conditional to check if user is present
    def user_present?
      user.present?
    end

    #
    # Conditional to check if collection belongs to user
    def collection_belongs_to_user?
      record.present? && user.present? && record&.user&.id == user.id
    end
end
