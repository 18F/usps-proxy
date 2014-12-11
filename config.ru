require './lib/usps-proxy'

run Rack::URLMap.new(
  '/city_state' => USPS::Proxy::CityState,
  '/address_standardization' => USPS::Proxy::AddressStandardization
)