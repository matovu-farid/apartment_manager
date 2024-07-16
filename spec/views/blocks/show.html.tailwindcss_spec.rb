# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'blocks/show' do
  before do
    assign(:block, Block.create!(
                     name: 'Name',
                     apartment: nil,
                     user: nil
                   ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
