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
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(id)
    

  private

  def create_transactions(transactions_data)
    transactions_data.map do |transaction_data|
      Transactions.new(transaction_data, self)
    end
  end
end
