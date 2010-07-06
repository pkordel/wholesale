module Site::LineItem
  def self.included(model)
    model.class_eval do
      def wholesale_price_usd
        price
      end
    end
  end
end