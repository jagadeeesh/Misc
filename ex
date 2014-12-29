factory :product_with_metro, class: Metro do
    sequence(:name) { |n| "mike#{n}"}
    xero_tax_type 'OUTPUT'
    tax_rate '8'
    time_zone 'Eastern Time (US & Canada)' 
  end
  
  factory :product, class: Product do 
    sequence(:name) {|n| "Towel#{n}"} 
    unit_of_measurement 'piece'
    product_type 'rental'
    unit_price 5
    association :metro, :factory => :product_with_metro    
    after :build do |pro|
      pro.metro.products << pro
    end 
  end
///////////////////////////////////////////
require 'spec_helper'

describe "admin users" do 
  before(:each) do
    @admin = login_as_admin
    @products = FactoryGirl.create_list(:product, 4)
  end

  describe "/a/products" do 
    it "should have_content", js: true do
      visit admin_products_path
      Metro.all.each do |metro|
        select metro, from: 'metro'
        page.should have_content(metro.products.first.name)
        page.should have_content('New Product')
      end
    end
  end

  describe "/a/products/new" do
    it "should be able add new product" do
      Metro.all.each do |metro|
        visit new_admin_product_path(@products.first)
        fill_in 'Name', with: 'Towel'
        select metro, from: 'Metro'
        select Product::UNITS_OF_MEASUREMENT.first, from: 'Unit of measurement'
        fill_in 'Unit price', with: '5.0'
        fill_in 'Unit weight', with: '0.0'
        select Product::PRODUCT_TYPES.first, from: 'Product type'
        select Product::CATEGORIES.first, from: 'Category'
        click_button 'Create Product'

        product = Product.where(name: 'Towel').last
        product.should_not be_nil
        product.metro_id.should == metro.id
      end
    end
  end

end
