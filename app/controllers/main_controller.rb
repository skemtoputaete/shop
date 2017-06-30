class MainController < ApplicationController
  def index
    @categories = Category.where("parentId = 0")
  end
end
