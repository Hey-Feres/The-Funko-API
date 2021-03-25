# frozen_string_literal: true

#
# Policy that handle the wish list's permissions
class WishListPolicy < ApplicationPolicy
  #
  # Scope defined for wish lists
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
    wish_list_belongs_to_user?
  end

  #
  # Authorization for create action
  def create?
    user_present?
  end

  #
  # Authorization for update action
  def update?
    wish_list_belongs_to_user?
  end

  #
  # Authorization for destroy action
  def destroy?
    wish_list_belongs_to_user?
  end

  private
    #
    # Conditional to check if user is present
    def user_present?
      user.present?
    end

    #
    # Conditional to check if wish list belongs to user
    def wish_list_belongs_to_user?
      record.present? && user.present? && record&.user&.id == user.id
    end
end
