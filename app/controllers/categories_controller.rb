class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    #@products = Product.where(category_id: @category.children.split(',') )
    #@category.products
    @subcategories = Category.where(parentId: @category.id)
  end
end
