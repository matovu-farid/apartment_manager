# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'apartments/new' do
  before do
    assign(:apartment, Apartment.new(
                         price: 1,
                         floor: 'MyString',
                         name: 1
                       ))
  end

  it 'renders new apartment form' do
    render

    assert_select 'form[action=?][method=?]', apartments_path, 'post' do
      assert_select 'input[name=?]', 'apartment[price]'

      assert_select 'input[name=?]', 'apartment[floor]'

      assert_select 'input[name=?]', 'apartment[name]'
    end
  end
end
