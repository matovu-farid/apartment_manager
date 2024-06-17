require 'rails_helper'

RSpec.describe "rent_sessions/index", type: :view do
  before(:each) do
    assign(:rent_sessions, [
      RentSession.create!(
        resident: nil,
        apartment: nil,
        isPaid: false
      ),
      RentSession.create!(
        resident: nil,
        apartment: nil,
        isPaid: false
      )
    ])
  end

  it "renders a list of rent_sessions" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
  end
end
