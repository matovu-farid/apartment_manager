# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'rent_sessions/show' do
  before do
    assign(:rent_session, RentSession.create!(
                            paymentDueDate: 'Payment Due Date',
                            resident: nil,
                            apartment: nil
                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Payment Due Date/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
