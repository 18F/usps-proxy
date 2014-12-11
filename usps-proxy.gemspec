# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'usps-proxy/version'

Gem::Specification.new do |spec|
  spec.name          = "usps-proxy"
  spec.version       = UspsProxy::VERSION
  spec.authors       = ["Alan deLevie"]
  spec.email         = ["alan.delevie@gsa.gov"]
  spec.summary       = %q{Some space between the USPS API and your users}
  spec.description   = %q{Makes the USPS API a bit easier to consumer on the client-side.}
  spec.homepage      = ""
  spec.license       = "Public Domain. See LICENSE.md"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  
  spec.add_dependency "dotenv"
  spec.add_dependency "sinatra"
  spec.add_dependency "usps"
  spec.add_dependency "thin"
  
end
