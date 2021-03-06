class Product < ApplicationRecord
  self.table_name = "ms_product"

  mount_uploader :pic, PictureUploader

  belongs_to :category
  has_many :positions
  has_many :orders, through: :positions
end
