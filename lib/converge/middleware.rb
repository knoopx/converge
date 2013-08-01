require 'logger'
require 'converge/engine'

module Converge
  class Middleware
    def initialize(app, logger = Logger.new(nil))
      @app, @logger = app, logger
    end

    def call(env)
      engine = ::Converge::Engine.new(env, ::Converge.rules)
      if engine.rewritten?
        @logger.info "[Converge] Request redirected. Match: #{engine.match.args.inspect} at #{engine.match.block.source_location.join(":")}"
        [engine.code, engine.headers, engine.body]
      else
        @app.call(env)
      end
    end
  end
end