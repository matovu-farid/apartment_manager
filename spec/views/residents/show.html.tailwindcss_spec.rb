# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'residents/show' do
  before do
    assign(:resident, Resident.create!(
                        name: 'Name',
                        physicalId: 'Physical',
                        phonenumber: 'Phonenumber',
                        user: nil
                      ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Physical/)
    expect(rendered).to match(/Phonenumber/)
    expect(rendered).to match(//)
  end
end
