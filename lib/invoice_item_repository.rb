require_relative 'invoice_item'

class InvoiceItemRepository
  attr_accessor :invoice_items
  attr_reader   :sales_engine
  include Loader

  def initialize(invoice_item_data = [], sales_engine = nil)
    @invoice_items = create_invoice_items(invoice_item_data)
    @sales_engine = sales_engine
  end

  def from_csv(path)
    @invoice_items = create_invoice_items(Loader.load_invoice_items(path))
  end

  def all
    invoice_items
  end

  def find_by_id(id)
    invoice_items.find do |invoice_item|
      invoice_item.id == id.to_i
    end
  end

  def find_all_by_item_id(id)
    invoice_items.find_all do |invoice_item|
      invoice_item.item_id == id.to_i
    end
  end

  def find_all_by_invoice_id(id)
    invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == id.to_i
    end
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  private

  def create_invoice_items(invoice_items_data)
    invoice_items_data.map do |invoice_item|
      InvoiceItem.new(invoice_item, self)
    end
  end
end
