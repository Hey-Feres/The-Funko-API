# frozen_string_literal: true

#
# Policy that all the others inherits from
class ApplicationPolicy
  #
  # Virtual Attributes
  #

  attr_reader :user, :record

  #
  # Methods
  #

  #
  # Initialize the class
  def initialize(user, record)
    @user = user
    @record = record
  end

  #
  # Reference to the index actions
  def index?
    false
  end

  #
  # Reference to the show actions
  def show?
    false
  end

  #
  # Reference to the create actions
  def create?
    false
  end

  #
  # Reference to the update actions
  def update?
    false
  end

  #
  # Reference to the destroy actions
  def destroy?
    false
  end

  #
  # Base scope
  class Scope
    #
    # Virtual Attributes
    #

    attr_reader :user, :scope

    #
    # Methods
    #

    #
    # Initialize the class
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    #
    # Define the base scope
    def resolve
      scope.all
    end
  end
end
