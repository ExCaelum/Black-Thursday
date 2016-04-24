require_relative 'transaction'

class TransactionRepository
  attr_accessor :transactions
  attr_reader   :sales_engine
  include Loader

  def initialize(transactions_data = [], sales_engine = nil)
    @transactions = create_transactions(transactions_data)
    @sales_engine = sales_engine
  end

  def from_csv(path)
    transactions = create_transactions(Loader.load_transactions(path))
  end

  def all
    transactions
  end

  def find_by_id(id)
    transactions.find do |transaction|
      transaction.id == id.to_i
    end
  end

  def find_all_by_invoice_id(id)
    transactions.find_all do |transaction|
      transaction.invoice_id == id.to_i
    end
  end

  def find_all_by_credit_card_number(ccn)
    transactions.find_all do |transaction|
      transaction.credit_card_number == ccn.to_i
    end
  end

  def find_all_by_result(result)
    transactions.find_all do |transaction|
      transaction.result.downcase == result.downcase
    end
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  private

  def create_transactions(transactions_data)
    transactions_data.map do |transaction_data|
      Transaction.new(transaction_data, self)
    end
  end
end
