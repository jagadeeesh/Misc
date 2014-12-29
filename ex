factory :plant do
    name '10th Spruce'
    address "10th Spruce; Philadelphia; PA"
  end
    
  factory :metro do
    sequence(:name) { |n| "mike#{n}"}
    xero_tax_type 'OUTPUT'
    tax_rate '8'
    time_zone 'Eastern Time (US & Canada)' 
  end
  factory :product do 
    name 'Towel'
    unit_of_measurement 'piece'
    product_type 'rental'
    unit_price 5    
  end
///////////////////////////////////////////
require 'spec_helper'

describe "admin users" do 
  before(:each) do
    @admin = login_as_admin
    @metros = FactoryGirl.create_list(:metro, 3)
    @product = FactoryGirl.create(:product)
  end

  describe "/a/products" do 
    it "should have_content" do
      visit admin_products_path
      @metros.each do |metro|
        select metro.name, from: 'metro'
        page.should have_content(metro.name)
        page.should have_content('New Product')
      end
    end
  end

  describe "/a/products/new" do
    it "should be able add new product" do
      @metros.each do |metro|
        visit new_admin_product_path(@product)
        fill_in 'Name', with: 'Towel'
        select metro, from: 'Metro'
        select Product::UNITS_OF_MEASUREMENT.first, from: 'Unit of measurement'
        fill_in 'Unit price', with: '5.0'
        fill_in 'Unit weight', with: '0.0'
        select Product::PRODUCT_TYPES.first, from: 'Product type'
        select Product::CATEGORIES.first, from: 'Category'
        click_button 'Create Product'

        product = Product.find(@product)
        product.should_not be_nil
        product.name.should == 'Towel'
        #product.metro..should == 162
      end

    end
  end

end
