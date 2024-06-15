require 'rails_helper'

RSpec.describe "blocks/index", type: :view do
  before(:each) do
    assign(:blocks, [
      Block.create!(
        name: "Name",
        apartment: nil,
        user: nil
      ),
      Block.create!(
        name: "Name",
        apartment: nil,
        user: nil
      )
    ])
  end

  it "renders a list of blocks" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
