# frozen_string_literal: true

# spec/controllers/concerns/payable_spec.rb
require 'rails_helper'

RSpec.describe DummyController do
  controller do
    include Payable
  end

  describe '#payment_due_date' do
    it 'returns the same day of the next month for regular dates' do
      date = Date.new(2024, 1, 15)
      expect(controller.payment_due_date(date)).to eq(Date.new(2024, 2, 15))
    end

    it 'handles February for non-leap years' do
      date = Date.new(2024, 1, 31)
      expect(controller.payment_due_date(date)).to eq(Date.new(2024, 2, 29))
    end

    it 'handles February for leap years' do
      date = Date.new(2023, 1, 31)
      expect(controller.payment_due_date(date)).to eq(Date.new(2023, 2, 28))
    end

    it 'returns the last day of the next month if the current day does not exist in the next month' do
      date = Date.new(2024, 5, 31) # May has 31 days, June has 30 days
      expect(controller.payment_due_date(date)).to eq(Date.new(2024, 6, 30))
    end

    it 'handles the transition from December to January' do
      date = Date.new(2023, 12, 31)
      expect(controller.payment_due_date(date)).to eq(Date.new(2024, 1, 31))
    end
  end

  describe '#payment_due_date_from_start_date' do
    it 'returns the same day of the next month for regular dates from start date' do
      start_date = Date.new(2022, 1, 1)
      expectedDate = Time.zone.today.change(day: 1, month: Time.zone.today.month + 1)

      expect(controller.payment_due_date_from_start_date(start_date)).to eq(expectedDate)
    end
  end
end
