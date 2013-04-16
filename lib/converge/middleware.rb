require 'converge/engine'

module Converge
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      engine = ::Converge::Engine.new(env, ::Converge.rules)
      if engine.rewritten?
        [engine.code, engine.headers, engine.body]
      else
        @app.call(env)
      end
    end
  end
end