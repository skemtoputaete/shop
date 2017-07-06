require 'spec_helper'
require 'rails_helper'



describe CategoriesController, :type => :controller do

include Devise::Test::ControllerHelpers

  describe "show controller" do

    it "paginator" do
      category = create(:category, id: 3708)

      product1 = create(:product)
      product2 = create(:product)
      product3 = create(:product)
      product4 = create(:product)
      product5 = create(:product)
      product6 = create(:product)
      product7 = create(:product)
      product8 = create(:product)

      category.products << product1
      category.products << product2
      category.products << product3
      category.products << product4
      category.products << product5
      category.products << product6
      category.products << product7
      category.products << product8

      get :show, params: { id: category.id, page: 1 }

      expect(category.products.paginate(page: 1, per_page: 5)).to eq(assigns(:products))

    end

  end

end
