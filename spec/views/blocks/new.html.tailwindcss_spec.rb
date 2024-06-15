require 'rails_helper'

RSpec.describe "blocks/new", type: :view do
  before(:each) do
    assign(:block, Block.new(
      name: "MyString",
      apartment: nil,
      user: nil
    ))
  end

  it "renders new block form" do
    render

    assert_select "form[action=?][method=?]", blocks_path, "post" do

      assert_select "input[name=?]", "block[name]"

      assert_select "input[name=?]", "block[apartment_id]"

      assert_select "input[name=?]", "block[user_id]"
    end
  end
end
