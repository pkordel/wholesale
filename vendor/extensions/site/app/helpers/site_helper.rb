module SiteHelper
  def price_type
    wholesale = @order.user.roles.map(&:name).include? "wholesale"
    currency = @order.currency
    if wholesale
      currency == 'USD' ? 'wholesale_usd' : 'wholesale'
    else
      currency == 'USD' ? 'price_usd' : 'price'
    end
  end
end