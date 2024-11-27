require 'rails_helper'

RSpec.describe "expenditures/edit", type: :view do
  let(:expenditure) {
    Expenditure.create!(
      name: "MyString",
      reference: "MyString",
      description: "MyText",
      amount: 1,
      category: "MyString"
    )
  }

  before(:each) do
    assign(:expenditure, expenditure)
  end

  it "renders the edit expenditure form" do
    render

    assert_select "form[action=?][method=?]", expenditure_path(expenditure), "post" do

      assert_select "input[name=?]", "expenditure[name]"

      assert_select "input[name=?]", "expenditure[reference]"

      assert_select "textarea[name=?]", "expenditure[description]"

      assert_select "input[name=?]", "expenditure[amount]"

      assert_select "input[name=?]", "expenditure[category]"
    end
  end
end
