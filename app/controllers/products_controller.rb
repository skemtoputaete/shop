class ProductsController < ApplicationController
  load_and_authorize_resource

  def index
    @products = Product.where("rating > 1000").order('id DESC').limit(9)
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
    #  @product.pic = params[:pic]
    #  @product.save
    redirect_to @product
  end

  def destroy
    Product.destroy(params[:id])
    redirect_back(fallback_location: root_path)
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description, :pic)
  end

end
