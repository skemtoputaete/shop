class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = Category.where("parentId = 0 and need_show = 1")

    @dontshow = Array.new
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
    $id = @category.id
    @subcategories = Category.where("parentId = #{$id} and need_show = 1")
    @products = Product.where(category_id: params[:id]).paginate(page: params[:page], per_page: 3)
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
end
