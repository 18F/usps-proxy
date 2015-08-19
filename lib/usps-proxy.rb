require 'usps-proxy/version'
require 'usps-proxy/protocol'
require 'usps-proxy/city_state'
require 'usps-proxy/address_standardization'

require 'bundler/setup'
require 'sinatra/base'

require 'usps'
require 'json'

module USPS
  module Proxy
  end
end
