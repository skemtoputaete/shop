class Order < ApplicationRecord
  belongs_to :user
  # has_and_belongs_to_many :products
  has_many :positions
  has_many :products, through: :positions
end
