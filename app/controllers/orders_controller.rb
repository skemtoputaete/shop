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

    if order.products.where(id: product.id).count != 0 then
      position = order.positions
      position = position.where(product_id: product.id).first
      position.quantity = position.quantity + 1
      position.save
    else
      order.products << product
    end

    respond_to do |format|
      if order.save
        format.html { redirect_back(fallback_location: root_path) }
        format.js { render js: 'alert("Товар был успешно добавлен в активный заказ.")'}
        format.json { render json: order, status: :created, location: order }
      else
        format.html { redirect_back(fallback_location: root_path) }
        format.json { render json: order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    order = Order.find(params[:id])
    order.positions.destroy
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

  def change_quantity
    @position = Position.find(params[:position_id])
  end

  def update_quantity
    position = Position.find(params[:position_id])
    res = position.update(quantity: params[:quantity])

    respond_to do |format|
      if res
        format.html { redirect_to orders_path }
        format.js { render js: 'alert("Количество товара было успешно изменено!")'}
        format.json { render json: order, status: :created, location: order }
      else
        format.html { redirect_back(fallback_location: root_path) }
        format.json { render json: order.errors, status: :unprocessable_entity }
      end
    end

    # position.update(quantity: params[:quantity])
    # redirect_to orders_path
  end

  private

  def quantity_params
    params.require(:position).permit(:quantity)
  end

end
