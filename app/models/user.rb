# frozen_string_literal: true

class User < ActiveRecord::Base
  #
  # Devise
  #

  devise :database_authenticatable, :registerable, :recoverable, :validatable

  #
  # Modules
  #

  include DeviseTokenAuth::Concerns::User

  #
  # Association
  #

  has_many :collections
  has_many :wish_lists

  #
  # Callbacks
  #

  after_create :create_default_collection
  after_create :create_default_wish_list

  #
  # Methods
  #

  #
  # Add a default collection to user when created
  def create_default_collection
    collections.create(name: 'My Collection')
  end

  #
  # Add a default wish list to user when created
  def create_default_wish_list
    wish_lists.create(name: 'My Wish List')
  end
end
