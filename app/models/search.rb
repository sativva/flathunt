class Search < ApplicationRecord
  has_many :announces
  accepts_nested_attributes_for :announces
  validates :username, presence: true, uniqueness: true#, length: { maximum: 100 }
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :location, presence: true
  validates :surface, presence: true
  validates :price, presence: true
end
