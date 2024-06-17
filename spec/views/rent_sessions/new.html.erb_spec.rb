require 'rails_helper'

RSpec.describe "rent_sessions/new", type: :view do
  before(:each) do
    assign(:rent_session, RentSession.new(
      resident: nil,
      apartment: nil,
      isPaid: false
    ))
  end

  it "renders new rent_session form" do
    render

    assert_select "form[action=?][method=?]", rent_sessions_path, "post" do

      assert_select "input[name=?]", "rent_session[resident_id]"

      assert_select "input[name=?]", "rent_session[apartment_id]"

      assert_select "input[name=?]", "rent_session[isPaid]"
    end
  end
end
