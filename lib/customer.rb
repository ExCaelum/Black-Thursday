class Customer
  attr_accessor :customer_data
  attr_reader   :customer_repo

  def initialize(customer_data, customer_repo = nil)
    @customer_data = customer_data
    @customer_repo = customer_repo
  end

  def id
    customer_data[:id].to_i
  end

  def first_name
    customer_data[:first_name]
  end

  def last_name
    customer_data[:last_name]
  end

  def created_at
    if customer_data[:created_at].class == String
      Time.parse(customer_data[:created_at])
    elsif customer_data[:created_at].class == Time
      customer_data[:created_at]
    end
  end

  def updated_at
    if customer_data[:updated_at].class == String
      Time.parse(customer_data[:updated_at])
    elsif customer_data[:updated_at].class == Time
      customer_data[:updated_at]
    end
  end
end
