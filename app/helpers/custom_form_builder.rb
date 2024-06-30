# app/helpers/custom_form_builder.rb
class CustomFormBuilder < ActionView::Helpers::FormBuilder
  def currency(method, options = {})
    @template.content_tag(:div, data: {controller: "currency"}) do
      text_field(method, options.merge(type: "currency", class: "form-control", data: {currency_target: "currency"}))
    end
  end
end
