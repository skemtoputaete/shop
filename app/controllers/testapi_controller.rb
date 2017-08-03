class TestapiController < ApplicationController
  def index
    @categories = Category.readonly.where('parentId = 0 and need_show = 1')
    respond_to do |format|
      format.html
      format.json { render json: @categories }
    end
  end

  def show
    category = Category.where("parentId = #{params[:id]} and need_show = 1")
    respond_to do |format|
      format.html
      format.json { render json: category }
    end
  end

  def products
    products = Product.where(category_id: params[:id])
    respond_to do |format|
      format.html
      format.json { render json: products }
    end
  end

  def description
    product = Product.find params[:id]
    respond_to do |format|
      format.html
      format.json { render json: product }
    end
  end
end
