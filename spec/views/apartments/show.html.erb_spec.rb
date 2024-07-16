# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'apartments/show' do
  before do
    assign(:apartment, Apartment.create!(
                         price: 2,
                         floor: 'Floor',
                         name: 3
                       ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Floor/)
    expect(rendered).to match(/3/)
  end
end
