class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    categories = Category.where('parentId = 0 and need_show = 1')
    render 'index', locals: { categories: categories }
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
    @category.destroy
  end

  def show
    # Find the parent category
    category = Category.find(params[:id])
    # Find children categories of the parent category
    subcategories = Category.where("parentId = #{params[:id]} and need_show = 1")
    # Find products belonging to parent category
    products = Product.where(category_id: params[:id]).paginate(page: params[:page], per_page: 3)

    render 'show', locals: { category: category, subcategories: subcategories, products: products }
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  #  Используется для удаления категории
  #  Для того, чтобы удалить категорию,
  #  необходимо также удалить все подкатегории принадлежащие ей
  def deleteCategory(category)
    #  Находим подкатегории удаляемой категории
    subcategories = Category.where(parentId: category.id)

    if subcategories.count != 0
      #  Для каждой подкатегории нужно:
      #  1. Найти ее подкатегории
      #  2. Удалить принадлежащие ей товары
      #  3. Удалить подкатегорию
      subcategories.each do |subcategory|
        deleteCategory subcategory
        Product.where(category_id: subcategory.id).delete_all
        Category.delete(subcategory.id)
      end
    else
      Product.where(category_id: category.id).delete_all
    end
  end
end
