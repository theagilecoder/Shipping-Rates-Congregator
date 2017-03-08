class Shipment < ApplicationRecord
  
  def origin
    ActiveShipping::Location.new(country: "US", state: "AR", city: "Bentonville", postal_code: "72712")
  end
  
  def destination
    ActiveShipping::Location.new(country: country, state: state, city: city, postal_code: postal_code)
  end
  
  def package
    ActiveShipping::Package.new(weight, [length, width, height], cylinder: cylinder)
  end
  
  def get_rates_from_shipper(shipper)
    response = shipper.find_rates(origin, destination, package)
    response.rates.sort_by(&:price)
  end

  def ups_rates
    ups = ActiveShipping::UPS.new(login: 'shopifolk', password: 'Shopify_rocks', key: '7CE85DED4C9D07AB')
    get_rates_from_shipper(ups)
  end
  
  def usps_rates
    usps = ActiveShipping::USPS.new(login: '677JADED7283')
    get_rates_from_shipper(usps)
  end
  
end