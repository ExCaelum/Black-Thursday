class Transaction
  attr_accessor :transaction_data
  attr_reader   :transaction_repo

  def initialize(transaction_data, transaction_repo = nil)
    @transaction_data = transaction_data
    @transaction_repo = transaction_repo
  end

  def id
    transaction_data[:id].to_i
  end

  def invoice_id
    transaction_data[:invoice_id].to_i
  end

  def credit_card_number
    transaction_data[:credit_card_number].to_i
  end

  def credit_card_expiration_date
    transaction_data[:expiration_date].to_i
  end

  def result
    transaction_data[:result]
  end

  def created_at
    merchant_data[:created_at]
  end

  def updated_at
    merchant_data[:updated_at]
  end
end
