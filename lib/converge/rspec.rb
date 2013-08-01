require 'rspec/expectations'
require 'active_support/concern'

module Converge
  module RSpec
    ::RSpec::Matchers.define :redirect_to do |expected|

      description do |engine|
        "redirect #{request(engine.env).url} to #{expected}"
      end

      match do |actual|
        actual.headers["Location"] == expected && code_matches?(actual)
      end

      def code_matches?(actual)
        @code ? actual.code == @code : true
      end

      def request(env)
        Rack::Request.new(env)
      end

      chain(:with) { |code| @code = code }
    end

    module Matchers
      extend ActiveSupport::Concern

      def request(uri, &block)
        block.call(response(uri))
      end

      def response(uri)
        Converge::Engine.new(Rack::MockRequest.env_for(uri), Converge.rules)
      end

      module ClassMethods
        def request(uri, &block)
          context do
            subject { response(uri) }
            example(&block)
          end
        end
      end
    end
  end
end