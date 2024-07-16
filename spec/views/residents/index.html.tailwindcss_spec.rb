# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'residents/index' do
  before do
    assign(:residents, [
             Resident.create!(
               name: 'Name',
               physicalId: 'Physical',
               phonenumber: 'Phonenumber',
               user: nil
             ),
             Resident.create!(
               name: 'Name',
               physicalId: 'Physical',
               phonenumber: 'Phonenumber',
               user: nil
             )
           ])
  end

  it 'renders a list of residents' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Name'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Physical'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Phonenumber'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
