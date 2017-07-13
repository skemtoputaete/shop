class OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    # На случай, если был выключен JavaScript
    if !params.empty? then
      @parametres = Hash.new
      params.each do |param|
        break if param == "commit" || param == "controller"
        @parametres[param] = params[param]
      end

      @parametres.each do |key, value|
        position = Position.find(key)
        position.quantity = value
        position.save
      end
    end

    if current_user != nil then
      user  = User.find(current_user.id)
      @orders = user.orders.where(status: false)
    end
  end

  def new

  end

  def create
    user  = User.find(current_user.id)
    order = user.orders
    # Выбираем незавершенные заказы
    order = order.where(status: false)
    # Если незавершенных заказов нет, то
    if order.count == 0 then
      # Создаем новый
      order = Order.create(user_id: current_user.id, status: 0)
    else
      # В противном случае используем самый первый незавершенный заказ
      order = order.first
    end

    product = Product.find(params[:id])
    # Если в данном заказе уже имеется тот товар, который пользователь хочет добавить, то
    if order.products.where(id: product.id).count != 0 then
      # Увеличиваем количество товара в заказе
      position = order.positions.where(product_id: product.id).first
      position.quantity += 1
      position.save
    else
      # Иначе добавляем данный в заказ
      order.products << product
    end

    # Ответ AJAX
    respond_to do |format|
      if order.save
        format.html { redirect_back(fallback_location: root_path) }
        format.js   { render js: 'alert("Товар был успешно добавлен в активный заказ.")'}
        format.json { render json: order, status: :created, location: order }
      else
        format.html { redirect_back(fallback_location: root_path) }
        format.json { render json: order.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    order = Order.find(params[:id])

    # Проверяем, не хочет ли пользователь удалить чужой заказ или уже завершенный
    if (order.user_id == current_user.id) && (!order.status) then
      Positions.where(order_id: order.id).delete_all
      order.destroy
      flash[:notice] = "Заказ был успешно удален."
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = "Заказа с таким номером не существует."
      redirect_back(fallback_location: root_path)
    end

  end

  def history
    @orders = User.find(current_user.id).orders
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
    # Определяем позицию товара в заказе
    # Необходимо для JavaScript
    @position_id = order.positions.where(product_id: product.id).first.id
    # Находим все активные заказы текущего пользователя
    # Это также необходимо для JavaScript
    @orders = User.find(current_user.id).orders.where(status: false)

    res = order.products.destroy(product)

    # Ответ AJAX
    respond_to do |format|
      if res
        format.html { redirect_to orders_path }
        format.js
        format.json { render json: order, status: :created, location: order }
      else
        format.html { redirect_back(fallback_location: root_path) }
        format.json { render json: order.errors, status: :unprocessable_entity }
      end
    end

  end

  def change_quantity
    @position = Position.find(params[:position_id])
  end

  def update_quantity
    position = Position.find(params[:position_id])
    res = position.update(quantity: params[:quantity])

    user  = User.find(current_user.id)
    @orders = user.orders.where(status: false)

    respond_to do |format|
      if res
        format.html { render partial: "cost_order", locals: { orders: @orders } }
        format.js
        format.json { render json: order, status: :created, location: order }
      else
        format.html { redirect_back(fallback_location: root_path) }
        format.json { render json: order.errors, status: :unprocessable_entity }
      end
    end

  end

  private

  def quantity_params
    params.require(:position).permit(:quantity)
  end

end
