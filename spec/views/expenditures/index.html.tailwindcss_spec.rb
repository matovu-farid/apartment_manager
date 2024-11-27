require 'rails_helper'

RSpec.describe "expenditures/index", type: :view do
  before(:each) do
    assign(:expenditures, [
      Expenditure.create!(
        name: "Name",
        reference: "Reference",
        description: "MyText",
        amount: 2,
        category: "Category"
      ),
      Expenditure.create!(
        name: "Name",
        reference: "Reference",
        description: "MyText",
        amount: 2,
        category: "Category"
      )
    ])
  end

  it "renders a list of expenditures" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Reference".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Category".to_s), count: 2
  end
end
