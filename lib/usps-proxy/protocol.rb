module USPS
  module Proxy
    module Protocol
      CITY_STATE_PARAMS = [
        {
          name: :zip5,
          required: true
        }
      ]

      ADDRESS_STANDARDIZATION_PARAMS = [
        {
          name: :firm,
          required: false
        },
        {
          name: :address1,
          required: true
        },
        {
          name: :address2,
          required: false
        },
        {
          name: :city,
          required: true
        },
        {
          name: :state,
          required: true
        },
        {
          name: :zip5,
          required: true
        },
        {
          name: :zip4,
          required: false
        }
      ]
    end
  end
end
