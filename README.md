# usps-proxy

[![Build Status](https://travis-ci.org/18F/usps-proxy.svg)](https://travis-ci.org/18F/usps-proxy) [![Code Climate](https://codeclimate.com/github/18F/usps-proxy/badges/gpa.svg)](https://codeclimate.com/github/18F/usps-proxy) [![Gem Version](https://badge.fury.io/rb/usps-proxy.svg)](http://badge.fury.io/rb/usps-proxy)

A Sinatra server that makes the USPS API a tad easier to consume on the client-side.

This gem sits alongside the namespace created by the [`USPS` gem](https://github.com/gaffneyc/usps).

## Why?

- The USPS API is XML-based. This gem makes it JSON-accessible.
- Keep API keys completely secret
- Monitor and throttle client-side requests to USPS's servers (tbd)

## What is supported?

This is still a work-in-progress, but there is basic support for:

- city/state lookup
- address standardization/verification

## Usage

### As part of a Rails app

In `Gemfile`:

```ruby
gem 'usps-proxy' # see README badge for latest version
```

By default, `USPS::Proxy` will look for the `USPS_USER` environment variable. However, you can override this in `config/initializers/[production|development|test].rb`:

```ruby
USPS.username = 'your usps username'
```

(note that this is a method on the [`USPS` gem](https://github.com/gaffneyc/usps) and not this gem)

USPS offers several APIs. You likely won't need to use all of them. Because of that, `USPS::Proxy` allows you to mix and match them:

In `config/routes.rb`:

```ruby
scope '/usps' do
  mount USPS::Proxy::CityState, at: '/city_state'
  mount USPS::Proxy::AddressStandardization, at: '/address_standardization'
end
```

Each API is its own mini `Sinatra` application with a single route, `'/'`.

### Standalone

Clone this repo and `cd` into it.

Edit `config.ru` as needed. Also be sure your `USPS_USER` environment variable is set (or user the `USPS.username` *somewhere* before the app runs).

```ruby
require './lib/usps-proxy'

run Rack::URLMap.new(
  '/city_state' => USPS::Proxy::CityState,
  '/address_standardization' => USPS::Proxy::AddressStandardization
)
```

```
$ bundle
$ bundle exec thin start
```

### APIs

#### City/State Lookup

GET `/city_state`

Request params (in the query string):

- `zip5` *required*

Example path: `/city_state?zip5=20006`

Example response:

```javascript
{
    "results": {
        "20008": {
            "zip": 20008,
            "city": "WASHINGTON",
            "state": "DC"
        }
    }
}
```

#### Address Standardization/Verification

GET `/address_standardization`

Request params (in the query string):

- `firm`
- `address1` *required*
- `address2`
- `city` *required*
- `state` *required*
- `zip5` *required*
- `zip4`

Example path: `/address_standardization?address1=1800%20F%20street%20NW&city=washington&state=DC&zip5=20006`

Example response:

```javascript
{
    "results": [
        {
            "name": null,
            "company": "",
            "address1": "1901 F ST NW",
            "address2": "",
            "city": "WASHINGTON",
            "state": "DC",
            "zip5": "20006",
            "zip4": "",
            "return_text": ""
        }
    ]
}
```

```javascript
{
    "results": [
        {
            "name": null,
            "company": "",
            "address1": "1801 F ST NW",
            "address2": "",
            "city": "WASHINGTON",
            "state": "DC",
            "zip5": "20006",
            "zip4": "4406",
            "return_text": "Default address: The address you entered was found but more information is needed (such as an apartment, suite, or box number) to match to a specific address."
        }
    ]
}
```

### Testing

```
$ rspec
```

## Public domain

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
