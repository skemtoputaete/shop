class Product < ApplicationRecord
  self.table_name = "ms_product"
  belongs_to :category
end
