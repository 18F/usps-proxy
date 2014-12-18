require 'sinatra'
require 'sinatra/base'
require 'rack/test'
require 'pry'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('<USPS_USER_ID (hidden)>') { ENV['USPS_USER'] }
end

require 'usps-proxy'
 
def app
  Rack::URLMap.new(
    '/city_state' => USPS::Proxy::CityState,
    '/address_standardization' => USPS::Proxy::AddressStandardization
  )
end
 
RSpec.configure do |config|
  config.tty = true
  config.formatter = :documentation
  config.include Rack::Test::Methods
  config.extend VCR::RSpec::Macros
end