# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payments/new' do
  before do
    assign(:payment, Payment.new(
                       rent_session: nil,
                       amount: ''
                     ))
  end

  it 'renders new payment form' do
    render

    assert_select 'form[action=?][method=?]', payments_path, 'post' do
      assert_select 'input[name=?]', 'payment[rent_session_id]'

      assert_select 'input[name=?]', 'payment[amount]'
    end
  end
end
