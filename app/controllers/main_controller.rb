class MainController < ApplicationController
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

  private
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

    #В противном случае, когда подкатегории нет собственных товаров, но есть потомки
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
