# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'apartments/index' do
  before do
    assign(:apartments, [
             Apartment.create!(
               price: 2,
               floor: 'Floor',
               name: 3
             ),
             Apartment.create!(
               price: 2,
               floor: 'Floor',
               name: 3
             )
           ])
  end

  it 'renders a list of apartments' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Floor'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
  end
end
