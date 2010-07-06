module Site::Product
  def self.included(model)
    model.class_eval do
      delegate_belongs_to :master, :wholesale_price_usd if Variant.column_names.include? "wholesale_price_usd"
    end
  end
end