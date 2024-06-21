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
end
