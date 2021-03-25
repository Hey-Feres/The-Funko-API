# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :collections
  has_many :wish_lists
end
