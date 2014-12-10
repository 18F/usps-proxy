# usps-proxy

A Sinatra server that makes the USPS API a tad easier to consume on the client-side.

## Why?

- The USPS API is XML-based. This makes is JSON-accessible.
- Keep API keys completely secret
- Monitor and throttle client-side requests to USPS's servers (tbd)

## What is supported?

This is still a work-in-progress, but there is basic support for:

- city/state lookup
- address verification/standardization

## Usage

### As part of a Rails app

In `Gemfile`:

```ruby
gem 'usps-proxy', github: '18F/usps-proxy', branch: 'master'
```

By default, `USPS::Proxy` will look for the `USPS_USER` environment variable. However, you can override this in `config/initializers/[production|development|test].rb`:

```ruby
USPS::Proxy.config do |c|
  c.usps_user = Rails.application.secrets.usps_user
end
```

USPS offers several APIs. You likely won't need to use all of them. Because of that, `USPS::Proxy` allows you to mix and match them:

In `config/routes.rb`:

```ruby
scope '/usps' do
  match '/city_state', USPS::Proxy::CityState
  match '/address_verification', USPS::Proxy::AddressVerification
end
```

### Standalone

TBD

### APIs

#### City/State Lookup

GET `/city_state`

Request params (in the query string):

- `zip5` *required*

Example path: `/city_state?zip5=20006`

#### Address Verification/standardization

GET `/address_verification`

Request params (in the query string):

- `firm`
- `address1` *required*
- `address2`
- `city` *required*
- `state` *required*
- `zip5` *required*
- `zip4`

Example path: `/address_verification?address1=1800F%20street%20NW&city=washington&state=DC&zip5=20006`

## Public domain

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.