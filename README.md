# Shipping Rates Congregator


This is an attempt in Ruby on Rails 5 to gather Shipping Rates from Carriers around the globe using their public APIs. This app uses Shopify's [Active Shipping library](https://github.com/Shopify/active_shipping) to abstract APIs of the following global carriers into a 1 handy library :

  - [UPS](https://www.ups.com/upsdeveloperkit?loc=en_US)
  - [USPS](https://www.usps.com/business/web-tools-apis/welcome.htm)
  - [Fedex](http://www.fedex.com/us/developer/)
  - [Canada Post](https://www.canadapost.ca/cpotools/apps/drc/home?execution=e1s1)
  - [New Zealand Post](https://www.nzpost.co.nz/business/developer-centre)
  - [Shipwire](https://www.shipwire.com/w/developers/)
  - [Australia Post](https://developers.auspost.com.au/)

If you have the time and patience to integrate each carrier individually then click above and read up on their documentation.


> I haven't designed any UI or API endpoints so currently **Rails Console** is the only way to **"Talk"**
> to Carrier APIs and do stuff like Address Validation, fetching shipping rates, tracking
> shipments etc.


### Example - Get international rates for cylindrical package from UPS 

Fire up Rails console and initialize your package with weight, dimensions. Note that all carriers use dimensional weight and hence cylindrical vs. cubic calculation are different.

```sh
$ packages = ActiveShipping::Package.new(100, [93,10], cylinder: true)
```

Setup Origin and Destination addresses

```sh
$ origin = ActiveShipping::Location.new(country: 'US', state: 'CA', city: 'Beverly Hills', zip: '90210')
$ destination = ActiveShipping::Location.new(country: 'CA', province: 'ON', city: 'Ottawa', postal_code: 'K1P 1J1')
```

Login to UPS (Please register and get your own Developer Access Key)

```sh
$ ups = ActiveShipping::UPS.new(login: 'shopifolk', password: 'Shopify_rocks', key: '7CE85DED4C9D07AB')
```

Find out shipping rate

```sh
$ response = ups.find_rates(origin, destination, packages)
```

You should receive a XML response from UPS detailing out their rates for different tiers.

```sh
  {"Response"=>
    {"ResponseStatusCode"=>"1", "ResponseStatusDescription"=>"Success"},
   "RatedShipment"=>
    [{"Service"=>{"Code"=>"07"},
      "RatedShipmentWarning"=>
       "Your invoice may vary from the displayed reference rates",
      "BillingWeight"=>{"UnitOfMeasurement"=>{"Code"=>"LBS"}, "Weight"=>"5.0"},
      "TransportationCharges"=>
       {"CurrencyCode"=>"USD", "MonetaryValue"=>"127.38"},
      "ServiceOptionsCharges"=>
       {"CurrencyCode"=>"USD", "MonetaryValue"=>"0.00"},
      "TotalCharges"=>{"CurrencyCode"=>"USD", "MonetaryValue"=>"127.38"},
      "GuaranteedDaysToDelivery"=>"1",
      "ScheduledDeliveryTime"=>"12:00 Noon",
      "RatedPackage"=>
       {"TransportationCharges"=>
         {"CurrencyCode"=>"USD", "MonetaryValue"=>"0.00"},
        "ServiceOptionsCharges"=>
         {"CurrencyCode"=>"USD", "MonetaryValue"=>"0.00"},
        "TotalCharges"=>{"CurrencyCode"=>"USD", "MonetaryValue"=>"0.00"},
        "Weight"=>"0.3",
        "BillingWeight"=>
         {"UnitOfMeasurement"=>{"Code"=>"LBS"}, "Weight"=>"5.0"}}},
     {"Service"=>{"Code"=>"08"},
      "RatedShipmentWarning"=>
       "Your invoice may vary from the displayed reference rates",
      "BillingWeight"=>{"UnitOfMeasurement"=>{"Code"=>"LBS"}, "Weight"=>"5.0"},
      "TransportationCharges"=>
       {"CurrencyCode"=>"USD", "MonetaryValue"=>"113.61"},
      "ServiceOptionsCharges"=>
       {"CurrencyCode"=>"USD", "MonetaryValue"=>"0.00"},
      "TotalCharges"=>{"CurrencyCode"=>"USD", "MonetaryValue"=>"113.61"},
      "GuaranteedDaysToDelivery"=>nil,
      "ScheduledDeliveryTime"=>nil,
      "RatedPackage"=>
       {"TransportationCharges"=>
         {"CurrencyCode"=>"USD", "MonetaryValue"=>"0.00"},
        "ServiceOptionsCharges"=>
         {"CurrencyCode"=>"USD", "MonetaryValue"=>"0.00"},
        "TotalCharges"=>{"CurrencyCode"=>"USD", "MonetaryValue"=>"0.00"},
        "Weight"=>"0.3",
        "BillingWeight"=>
         {"UnitOfMeasurement"=>{"Code"=>"LBS"}, "Weight"=>"5.0"}}},
     {"Service"=>{"Code"=>"65"},
      "RatedShipmentWarning"=>
       "Your invoice may vary from the displayed reference rates",
      "BillingWeight"=>{"UnitOfMeasurement"=>{"Code"=>"LBS"}, "Weight"=>"5.0"},
      "TransportationCharges"=>
       {"CurrencyCode"=>"USD", "MonetaryValue"=>"125.25"},
      "ServiceOptionsCharges"=>
       {"CurrencyCode"=>"USD", "MonetaryValue"=>"0.00"},
      "TotalCharges"=>{"CurrencyCode"=>"USD", "MonetaryValue"=>"125.25"},
      "GuaranteedDaysToDelivery"=>"1",
      "ScheduledDeliveryTime"=>nil,
      "RatedPackage"=>
       {"TransportationCharges"=>
         {"CurrencyCode"=>"USD", "MonetaryValue"=>"0.00"},
        "ServiceOptionsCharges"=>
         {"CurrencyCode"=>"USD", "MonetaryValue"=>"0.00"},
        "TotalCharges"=>{"CurrencyCode"=>"USD", "MonetaryValue"=>"0.00"},
        "Weight"=>"0.3",
        "BillingWeight"=>
         {"UnitOfMeasurement"=>{"Code"=>"LBS"}, "Weight"=>"5.0"}}},
     {"Service"=>{"Code"=>"11"},
      "RatedShipmentWarning"=>
       "Your invoice may vary from the displayed reference rates",
      "BillingWeight"=>{"UnitOfMeasurement"=>{"Code"=>"LBS"}, "Weight"=>"5.0"},
      "TransportationCharges"=>
       {"CurrencyCode"=>"USD", "MonetaryValue"=>"30.75"},
      "ServiceOptionsCharges"=>
       {"CurrencyCode"=>"USD", "MonetaryValue"=>"0.00"},
      "TotalCharges"=>{"CurrencyCode"=>"USD", "MonetaryValue"=>"30.75"},
      "GuaranteedDaysToDelivery"=>nil,
      "ScheduledDeliveryTime"=>nil,
      "RatedPackage"=>
       {"TransportationCharges"=>
         {"CurrencyCode"=>"USD", "MonetaryValue"=>"0.00"},
        "ServiceOptionsCharges"=>
         {"CurrencyCode"=>"USD", "MonetaryValue"=>"0.00"},
        "TotalCharges"=>{"CurrencyCode"=>"USD", "MonetaryValue"=>"0.00"},
        "Weight"=>"0.3",
        "BillingWeight"=>
         {"UnitOfMeasurement"=>{"Code"=>"LBS"}, "Weight"=>"5.0"}}}]}
```