# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payments/index' do
  before do
    assign(:payments, [
             Payment.create!(
               rent_session: nil,
               amount: ''
             ),
             Payment.create!(
               rent_session: nil,
               amount: ''
             )
           ])
  end

  it 'renders a list of payments' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(''.to_s), count: 2
  end
end
