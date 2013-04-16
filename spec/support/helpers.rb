require 'active_support/concern'
require 'rack/mock'

module Helpers
  extend ActiveSupport::Concern

  def request(uri, &block)
    block.call(Converge::Engine.new(Rack::MockRequest.env_for(uri), Converge.rules))
  end

  module ClassMethods
    def rules(&block)
      before do
        @_rules = Converge.rules.dup
        Converge.rules.clear
        Converge.configure(&block)
      end
      after { Converge.rules.replace(@_rules) }
    end
  end
end