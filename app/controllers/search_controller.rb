class SearchController < ApplicationController
  def search
    if params[:search] != "" then
      @results = Product.search params[:search], :page => params[:page], :per_page => 10
    end
  end

  def search_autocomplete
    if params[:search] != "" then
      @results = Product.search :conditions => { :name => params[:search] }, :page => 1, :per_page => 5

      respond_to do |format|
        if @results
          format.html { render partial: 'result_autocomplete', collection: @results, as: :result }
          format.js
          format.json
        else
          format.html { redirect_back(fallback_location: root_path) }
          format.json { render json: order.errors, status: :unprocessable_entity }
        end
      end
    end
  end

end
