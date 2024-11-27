require 'rails_helper'

RSpec.describe "expenditures/new", type: :view do
  before(:each) do
    assign(:expenditure, Expenditure.new(
      name: "MyString",
      reference: "MyString",
      description: "MyText",
      amount: 1,
      category: "MyString"
    ))
  end

  it "renders new expenditure form" do
    render

    assert_select "form[action=?][method=?]", expenditures_path, "post" do

      assert_select "input[name=?]", "expenditure[name]"

      assert_select "input[name=?]", "expenditure[reference]"

      assert_select "textarea[name=?]", "expenditure[description]"

      assert_select "input[name=?]", "expenditure[amount]"

      assert_select "input[name=?]", "expenditure[category]"
    end
  end
end
