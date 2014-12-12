require 'bundler/setup'
require 'sinatra/base'
require 'pry'

module USPS
  module Proxy
    class AddressStandardization < Sinatra::Base
      get '/' do
        content_type :json     

        address = USPS::Address.new(params)
        request = USPS::Request::AddressStandardization.new(address)
        
        begin
          response = request.send!
          {
            results: response.to_h.values
          }.to_json
        rescue USPS::Error => error
          {
            error: error.message,
            code: error.number
          }.to_json
        end
      end
    end
  end
end