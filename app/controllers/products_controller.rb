class ProductsController < ApplicationController
  load_and_authorize_resource

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to @product
  end

  def destroy
    Product.destroy(params[:id])
    redirect_to categories_path
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :description)
  end
end
