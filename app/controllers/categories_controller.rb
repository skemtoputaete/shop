class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = Category.where("parentId = 0")

    @dontshow = Array.new

    # @categories.each do |category|
    #   check = checkCategory(category)
    #   if (!check) then
    #     @dontshow.push(category.id)
    #   end
    # end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params)
    redirect_to @category
  end

  def destroy
    @category = Category.find(params[:id])
    deleteCategory @category
  end

  def show
    @category = Category.find(params[:id])
    @subcategories = Category.where(parentId: @category.id)

    @dontshow = Array.new                 #Массив для хранения id подкатегорий
                                          #у которых нет товаров, которые не следует выводить

    #Теперь, для каждой подкатегории необходимо определить, стоит ли ее выводить
    @subcategories.each do |subcategory|
      check = checkSubcategory(subcategory)
      if (!check) then
        @dontshow.push(subcategory.id)
      end
    end

    @products = Product.where(category_id: params[:id]).paginate(page: params[:page], per_page: 5)
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  #Используется для удаления категории
  #Для того, чтобы удалить категорию, необходимо также удалить все подкатегории
  #принадлежащие ей
  def deleteCategory(category)
    subcategories = Category.where(parentId: category_id)

    subcategories.each do |subcategory|
      deleteCategory subcategory
      Product.destroy_all(category_id: subcategory.id)
      Category.destroy(subcategory.id)
    end
  end

  #Используется для проверки подкатегории каждой категории
  #При принятии решения о том, стоит ли выводить категорию в список
  def checkCategory(category)
    #Для каждой категории находим подкатегорию
    subcategories = Category.where(parentId: category.id)

    #Каждую подкатегорию проверяем
    subcategories.each do |subcategory|
      check = checkSubcategory(subcategory)
      if(check) then
        return true
      end
    end

    #Если ни одна из подкатегорий не удовлетворила критерию поиска
    #Возвращаем ложное значение
    return false
  end

  def checkSubcategory(subcategory)
    #hasChildren - флаг, говорящий о том, есть ли у подкатегории потомки
    #hasChildren == true - потомки есть
    if subcategory.children == nil then
      hasChildren = false
    else
      hasChildren = true
    end

    #countProducts - количество собственного товара у подкатегории
    countProducts = Product.where(category_id: subcategory.id).count

    #Если подкатегория имеет собственные товары, то ее необходимо вывести в списке
    if ( countProducts > 0 ) then
      return true
    end

    #Если подкатегория не имеет собственных товаров и потомков, ее не нужно выводить
    if (!hasChildren) then
      return false
    end

    #В противном случае, когда у подкатегории нет собственных товаров, но есть потомки
    #Потомков подкатегории необходимо исследовать дополнительно, т.к. у них могут быть товары
    #Если хотя бы один потомок имеет товары, то подкатегорию необходимо вывести
    children = Category.where(parentId: subcategory.id)
    children.each do |child|
      check = checkSubcategory(child)
      if (check) then
        return true
      end
    end

    #Если мы прошли проверку всех потомков и при этом не вернулись из функции
    #Значит подкатегорию выводить не стоит
    return false
  end

end
