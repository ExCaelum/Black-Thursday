require_relative 'customer'

class CustomerRepository
  attr_accessor :customers
  attr_reader   :sales_engine
  include Loader

  def initialize(customer_data = [], sales_engine = nil)
    @customers = create_customers(customer_data)
    @sales_engine = sales_engine
  end

  def from_csv(path)
    customers = create_customers(Loader.load_customers(path))
  end

  def all
    customers
  end

  def find_by_id(id)
    customers.find do |customer|
      customer.id == id.to_i
    end
  end

  def find_all_by_first_name(name)
    customers.find_all do |customer|
      customer.first_name.downcase.include? name.downcase
    end
  end

  def find_all_by_last_name(name)
    customers.find_all do |customer|
      customer.last_name.downcase.include? name.downcase
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  private

  def create_customers(customer_data)
    customer_data.map do |customer_data|
      Customer.new(customer_data, self)
    end
  end
end
