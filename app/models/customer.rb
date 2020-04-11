class Customer < ApplicationRecord
  validates :name, presence: true
  validates :lastname, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  has_many :orders
  has_many :tickets, through: :orders
end
