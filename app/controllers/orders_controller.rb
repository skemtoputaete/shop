class OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    user  = User.find(current_user.id)
    @orders = user.orders.where(status: false)
  end

  def new
    redirect_to action: "create", id: params[:id]
  end

  def create
    user  = User.find(current_user.id)
    order = user.orders
    order = order.where(status: false)
    if order.count == 0 then
      order = Order.create(user_id: current_user.id, status: 0)
    else
      order = order.first
    end
    product = Product.find(params[:id])
    order.products << product
    order.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    order = Order.find(params[:id])
    order.destroy
    redirect_back(fallback_location: root_path)
  end

  def history
    user  = User.find(current_user.id)
    @orders = user.orders
  end

  def buy
    order = Order.find(params[:id])
    order.status = true
    order.save
    redirect_back(fallback_location: root_path)
  end

  def delete_product
    product = Product.find(params[:product_id])
    order   = Order.find(params[:id])
    order.products.destroy(product)
    redirect_back(fallback_location: root_path)
  end

end
