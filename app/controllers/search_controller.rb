class SearchController < ApplicationController
  def search
    if params[:search] != nil then
      @results = Product.search(params[:search])
    end
  end
end
