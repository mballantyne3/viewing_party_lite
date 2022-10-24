# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password
  validates_presence_of :password_confirmation
  has_many :party_users
  has_many :parties, through: :party_users

  has_secure_password
end
