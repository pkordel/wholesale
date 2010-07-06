module Site::OrdersController
  def self.included(controller)
    controller.class_eval do

      def create_before
        set_currency
        params[:products].each do |product_id,variant_id|
          debugger
          quantity = params[:quantity].to_i if !params[:quantity].is_a?(Array)
          quantity = params[:quantity][variant_id].to_i if params[:quantity].is_a?(Array)
          variant = Variant.find(variant_id)
          if (!@order.currency.blank? && @order.currency == 'USD' && !variant.price_usd.blank?)          
            variant.price = variant.price_usd
          end
          if (!current_user.nil? && current_user.has_role?("wholesale") && !variant.wholesale_price.blank?)
            if (!@order.currency.blank? && @order.currency == 'USD' && !variant.wholesale_price_usd.blank?)          
              variant.price = variant.wholesale_price_usd
            else
              variant.price = variant.wholesale_price
            end
          end
          @order.add_variant(variant, quantity) if quantity > 0
        end if params[:products]

        params[:variants].each do |variant_id, quantity|
          quantity = quantity.to_i
          variant = Variant.find(variant_id)
          if (!@order.currency.blank? && @order.currency == 'USD' && !variant.price_usd.blank?)          
            variant.price = variant.price_usd
          end
          if (!current_user.nil? && current_user.has_role?("wholesale") && !variant.wholesale_price.blank?)
            if (!@order.currency.blank? && @order.currency == 'USD' && !variant.wholesale_price_usd.blank?)          
              variant.price = variant.wholesale_price_usd
            else
              variant.price = variant.wholesale_price
            end
          end
          @order.add_variant(variant, quantity) if quantity > 0
        end if params[:variants]

        # store order token in the session
        session[:order_token] = @order.token
      end
      
      def set_currency
        @order.currency = currency
      end
      
      def currency
        session[:currency] || DEFAULT_CURRENCY
      end
      
    end
  end
end