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
    transaction_data[:credit_card_expiration_date]
  end

  def result
    transaction_data[:result]
  end

  def created_at
    if transaction_data[:created_at].class == String
      Time.parse(transaction_data[:created_at])
    elsif transaction_data[:created_at].class == Time
      transaction_data[:created_at]
    end
  end

  def updated_at
    if transaction_data[:updated_at].class == String
      Time.parse(transaction_data[:updated_at])
    elsif transaction_data[:updated_at].class == Time
      transaction_data[:updated_at]
    end
  end

  def invoice
    transaction_repo.get_invoice(invoice_id)
  end
end
