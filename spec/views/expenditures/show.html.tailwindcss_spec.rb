require 'rails_helper'

RSpec.describe "expenditures/show", type: :view do
  before(:each) do
    assign(:expenditure, Expenditure.create!(
      name: "Name",
      reference: "Reference",
      description: "MyText",
      amount: 2,
      category: "Category"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Reference/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Category/)
  end
end
