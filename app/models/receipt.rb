class Receipt
  def initialize
    @receipt_items = []
  end

  def add_item(item)
    @receipt_items << item
  end

  def create_receipt_from_payment(payment)
    add_item(ReceiptItem.new("Payment ID", payment.id))
    add_item(ReceiptItem.new("Amount", payment.amount))
    add_item(ReceiptItem.new("Date", payment.created_at))
    add_item(ReceiptItem.new("Resident", payment.resident.name))
    add_item(ReceiptItem.new("Block", payment.resident.apartment.block.name))
    add_item(ReceiptItem.new("Apartment", payment.resident.apartment.name))
    add_item(ReceiptItem.new("User", payment.user.email))
  end

end
