# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :collections
  has_many :wish_lists

  after_create :create_default_collection
  after_create :create_default_wish_list

  def create_default_collection
    collections.create(name: 'My Collection')
  end

  def create_default_wish_list
    wish_lists.create(name: 'My Wish List')
  end
end
