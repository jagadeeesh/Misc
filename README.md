Misc
====

require 'spec_helper'

describe "admin users" do 
  before(:each) do
    @admin = login_as_admin
    @metro = FactoryGirl.create(:metro)
  end

  describe "/a/products" do 
    it "should have_content" do
      visit admin_products_path
      page.should have_content(@metro.name)
      page.should have_content('New Product')
    end
  end

  describe "/a/products/new" do
    it "should be able add new product" do

    end
  end

end
