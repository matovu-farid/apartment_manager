require 'rails_helper'

RSpec.describe "rent_sessions/edit", type: :view do
  let(:rent_session) {
    RentSession.create!(
      resident: nil,
      apartment: nil,
      isPaid: false
    )
  }

  before(:each) do
    assign(:rent_session, rent_session)
  end

  it "renders the edit rent_session form" do
    render

    assert_select "form[action=?][method=?]", rent_session_path(rent_session), "post" do

      assert_select "input[name=?]", "rent_session[resident_id]"

      assert_select "input[name=?]", "rent_session[apartment_id]"

      assert_select "input[name=?]", "rent_session[isPaid]"
    end
  end
end
