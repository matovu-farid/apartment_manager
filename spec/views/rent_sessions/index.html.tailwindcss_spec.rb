# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'rent_sessions/index' do
  before do
    assign(:rent_sessions, [
             RentSession.create!(
               paymentDueDate: 'Payment Due Date',
               resident: nil,
               apartment: nil
             ),
             RentSession.create!(
               paymentDueDate: 'Payment Due Date',
               resident: nil,
               apartment: nil
             )
           ])
  end

  it 'renders a list of rent_sessions' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Payment Due Date'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
