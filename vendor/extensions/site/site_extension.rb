# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SiteExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/site"

  # Please use site/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate

    ProductsHelper.send(:include, Site::ProductsHelper)
    
    OrdersController.send(:include, Site::OrdersController)
    
    Product.send(:include, Site::Product)
    
    LineItem.send(:include, Site::LineItem)
    
    Admin::OrdersController.send(:helper, MultipleCurrenciesHelper, SiteHelper)

    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
  end
end
