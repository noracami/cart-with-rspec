require 'rails_helper'

RSpec.describe "products/new", type: :view do
  before(:each) do
    assign(:product, Product.new(
      title: "MyString",
      price: 1,
      description: "MyText"
    ))
  end

  it "renders new product form" do
    render

    assert_select "form[action=?][method=?]", products_path, "post" do

      assert_select "input[name=?]", "product[title]"

      assert_select "input[name=?]", "product[price]"

      assert_select "textarea[name=?]", "product[description]"
    end
  end
end
