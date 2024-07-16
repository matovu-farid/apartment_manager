# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payments/show' do
  before do
    assign(:payment, Payment.create!(
                       rent_session: nil,
                       amount: ''
                     ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
