# frozen_string_literal: true

class WishListPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user&.id)
    end
  end

  def index?
    user_present?
  end

  def show?
    wish_list_belongs_to_user?
  end

  def create?
    user_present?
  end

  def update?
    wish_list_belongs_to_user?
  end

  def destroy?
    wish_list_belongs_to_user?
  end

  private
    def user_present?
      user.present?
    end

    def wish_list_belongs_to_user?
      record.present? && user.present? && record&.user&.id == user.id
    end
end
