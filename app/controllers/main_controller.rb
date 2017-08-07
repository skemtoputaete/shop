class MainController < ApplicationController
  def index
    categories = Category.readonly.where('parentId = 0 and need_show = 1')
    render 'index', locals: { categories: categories }
  end
end
