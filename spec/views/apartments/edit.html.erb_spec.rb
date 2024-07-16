# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'apartments/edit' do
  let(:apartment) do
    Apartment.create!(
      price: 1,
      floor: 'MyString',
      name: 1
    )
  end

  before do
    assign(:apartment, apartment)
  end

  it 'renders the edit apartment form' do
    render

    assert_select 'form[action=?][method=?]', apartment_path(apartment), 'post' do
      assert_select 'input[name=?]', 'apartment[price]'

      assert_select 'input[name=?]', 'apartment[floor]'

      assert_select 'input[name=?]', 'apartment[name]'
    end
  end
end
