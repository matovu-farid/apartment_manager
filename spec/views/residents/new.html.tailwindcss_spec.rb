require 'rails_helper'

RSpec.describe "residents/new", type: :view do
  before(:each) do
    assign(:resident, Resident.new(
      name: "MyString",
      physicalId: "MyString",
      phonenumber: "MyString",
      user: nil
    ))
  end

  it "renders new resident form" do
    render

    assert_select "form[action=?][method=?]", residents_path, "post" do

      assert_select "input[name=?]", "resident[name]"

      assert_select "input[name=?]", "resident[physicalId]"

      assert_select "input[name=?]", "resident[phonenumber]"

      assert_select "input[name=?]", "resident[user_id]"
    end
  end
end
