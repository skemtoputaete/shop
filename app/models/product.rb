class Product < ApplicationRecord
  self.table_name = "ms_product"
  belongs_to :category
  has_and_belongs_to_many :orders
end
