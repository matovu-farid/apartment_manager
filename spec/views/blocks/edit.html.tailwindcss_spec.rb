# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'blocks/edit' do
  let(:block) do
    Block.create!(
      name: 'MyString',
      apartment: nil,
      user: nil
    )
  end

  before do
    assign(:block, block)
  end

  it 'renders the edit block form' do
    render

    assert_select 'form[action=?][method=?]', block_path(block), 'post' do
      assert_select 'input[name=?]', 'block[name]'

      assert_select 'input[name=?]', 'block[apartment_id]'

      assert_select 'input[name=?]', 'block[user_id]'
    end
  end
end
