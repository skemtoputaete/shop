class SearchController < ApplicationController
  def search
    if params[:search] != nil then
      @results = Product.search(params[:search])

      respond_to do |format|
        if @results
          format.html { render partial: 'result', collection: @results }
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
