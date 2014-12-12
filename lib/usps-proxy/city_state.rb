require 'bundler/setup'
require 'sinatra/base'
require 'pry'
require 'json'

module USPS
  module Proxy
    
    class CityState < Sinatra::Base
      get '/' do
        content_type :json
              
        request = USPS::Request::CityAndStateLookup.new(params[:zip5])          
        
        begin
          response = request.send!          
          
          {
            results: response.to_h
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