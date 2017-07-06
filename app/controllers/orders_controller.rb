class OrdersController < ApplicationController
  load_and_authorize_resource
  def index
  end

  def new
    redirect_to action: "create", id: params[:id]
  end

  def create
    user  = User.find(current_user.id)
    order = user.orders
    # if order == nil then
    #   order = Order.create(user_id: current_user.id, status: 0)
    # end
    order = order.where(status: 0)
    if order.count == 0 then
      order = Order.create(user_id: current_user.id, status: 0)
    else
      order = order.first
    end
    #order = order.first
    product = Product.find(params[:id])
    order.products << product
    order.save
    redirect_to root_path
  end

  def destroy
  end
end
