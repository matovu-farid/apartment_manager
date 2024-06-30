module ApplicationHelper
  def format_currency(amount, unit: "UGX ", separator: ".", delimiter: ",")
    number_to_currency(
      amount,
      unit: unit,
      separator: separator,
      delimiter: delimiter,
      precision: 0
    )
  end

  def custom_form_with(model: nil, scope: nil, url: nil, format: nil, **options, &block)
    options[:builder] = CustomFormBuilder
    form_with(model: model, scope: scope, url: url, format: format, **options, &block)
  end
end
