# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payments/edit' do
  let(:payment) do
    Payment.create!(
      rent_session: nil,
      amount: ''
    )
  end

  before do
    assign(:payment, payment)
  end

  it 'renders the edit payment form' do
    render

    assert_select 'form[action=?][method=?]', payment_path(payment), 'post' do
      assert_select 'input[name=?]', 'payment[rent_session_id]'

      assert_select 'input[name=?]', 'payment[amount]'
    end
  end
end
