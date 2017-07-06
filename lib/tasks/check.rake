namespace :category do

  #Задача для проверки глобальных категорий
  task :check_category => :environment do
    @categories = Category.where(parentId: 0)

    @categories.each do |category|
      check = checkCategory(category)
      if !check then
        category.need_show = false
        category.save
      else
        category.need_show = true
        category.save
      end
    end
  end

  #Используется для проверки подкатегории каждой категории
  #При принятии решения о том, стоит ли выводить категорию в список
  def checkCategory(category)
    #Для каждой категории находим подкатегорию
    subcategories = Category.where(parentId: category.id)

    res = false

    #Каждую подкатегорию проверяем
    subcategories.each do |subcategory|
      check = checkSubcategory(subcategory)
      if check then
        subcategory.need_show = true
        subcategory.save
        res = true
      else
        subcategory.need_show = false
        subcategory.save
      end
    end

    #Если ни одна из подкатегорий не удовлетворила критерию поиска
    #Возвращаем ложное значение
    return res
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
      subcategory.need_show = true
      subcategory.save
      return true
    end

    #Если подкатегория не имеет собственных товаров и потомков, ее не нужно выводить
    if (!hasChildren) then
      subcategory.need_show = false
      subcategory.save
      return false
    end

    res = false

    #В противном случае, когда у подкатегории нет собственных товаров, но есть потомки
    #Потомков подкатегории необходимо исследовать дополнительно, т.к. у них могут быть товары
    #Если хотя бы один потомок имеет товары, то подкатегорию необходимо вывести
    children = Category.where(parentId: subcategory.id)
    children.each do |child|
      check = checkSubcategory(child)
      if check then
        child.need_show = true
        child.save
        res = true
      else
        child.need_show = false
        child.save
      end
    end

    #Если мы прошли проверку всех потомков и при этом не вернулись из функции
    #Значит подкатегорию выводить не стоит
    return res
  end
end
