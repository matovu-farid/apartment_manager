# frozen_string_literal: true

module ApplicationHelper
  def format_currency(amount, unit: 'UGX ', separator: '.', delimiter: ',')
    number_to_currency(
      amount,
      unit:,
      separator:,
      delimiter:,
      precision: 0
    )
  end

  def custom_form_with(model: nil, scope: nil, url: nil, format: nil, **options, &)
    options[:builder] = CustomFormBuilder
    form_with(model:, scope:, url:, format:, **options, &)
  end
end
