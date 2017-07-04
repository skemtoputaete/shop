require 'spec_helper'
require 'rails_helper'

RSpec.describe Product, :type => :model do
  it "should do smth" do
    category = create(:category)
    product1 = create(:product)
    category.products << product1
    expect(product1.category_id).to eq(category.id)
  end
end
