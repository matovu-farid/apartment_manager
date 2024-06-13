require 'rails_helper'

RSpec.describe "apartments/edit", type: :view do
  let(:apartment) {
    Apartment.create!(
      price: 1,
      floor: "MyString",
      apartmentnumber: 1
    )
  }

  before(:each) do
    assign(:apartment, apartment)
  end

  it "renders the edit apartment form" do
    render

    assert_select "form[action=?][method=?]", apartment_path(apartment), "post" do

      assert_select "input[name=?]", "apartment[price]"

      assert_select "input[name=?]", "apartment[floor]"

      assert_select "input[name=?]", "apartment[apartmentnumber]"
    end
  end
end
