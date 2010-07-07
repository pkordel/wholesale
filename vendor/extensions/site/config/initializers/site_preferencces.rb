# load up preferences here
if Spree::Config.instance
  Spree::Config.set(:auto_capture => true)
end