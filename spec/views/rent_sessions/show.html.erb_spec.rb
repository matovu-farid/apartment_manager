# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'rent_sessions/show' do
  before do
    assign(:rent_session, RentSession.create!(
                            resident: nil,
                            apartment: nil,
                            isPaid: false
                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
