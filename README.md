# usps-proxy

A Sinatra server that makes the USPS API a tad easier to consume on the client-side.

## Why?

- The USPS API is XML-based. This gem makes it JSON-accessible.
- Keep API keys completely secret
- Monitor and throttle client-side requests to USPS's servers (tbd)

## What is supported?

This is still a work-in-progress, but there is basic support for:

- city/state lookup
- address verification/standardization

## Public domain

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.