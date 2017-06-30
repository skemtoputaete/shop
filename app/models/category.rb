class Category < ApplicationRecord
  self.table_name = 'ms_category'
  has_many :products
end
