require 'rspec/core'
require 'converge'
require 'converge/rspec'
require 'support/helpers'

RSpec.configure do |config|
  config.include(Helpers)
  config.include(Converge::RSpec::Matchers)
end