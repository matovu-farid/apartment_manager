# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'residents/edit' do
  let(:resident) do
    Resident.create!(
      name: 'MyString',
      physicalId: 'MyString',
      phonenumber: 'MyString',
      user: nil
    )
  end

  before do
    assign(:resident, resident)
  end

  it 'renders the edit resident form' do
    render

    assert_select 'form[action=?][method=?]', resident_path(resident), 'post' do
      assert_select 'input[name=?]', 'resident[name]'

      assert_select 'input[name=?]', 'resident[physicalId]'

      assert_select 'input[name=?]', 'resident[phonenumber]'

      assert_select 'input[name=?]', 'resident[user_id]'
    end
  end
end
