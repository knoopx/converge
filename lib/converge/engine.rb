require 'addressable/uri'

module Converge
  class Engine
    attr_accessor :code, :headers, :body

    def initialize(env, rules)
      @env = env
      @code, @headers, @body = 404, {}, []
      @rewritten = false

      rules.each do |rule|
        if (matches = rule.match(request))
          if matches.is_a?(Array)
            self.instance_exec(*matches, &rule.block)
          else
            self.instance_exec(&rule.block)
          end
          break if rewritten?
        end
      end
    end

    def rewritten?
      @rewritten
    end

    def request
      @request ||= Rack::Request.new(@env)
    end

    def redirect(location, opts = {})
      if location.is_a?(Hash)
        uri = Addressable::URI.parse(request.url).merge(location)
      else
        if opts.fetch(:absolute, false)
          uri = Addressable::URI.parse(request.url).merge(Addressable::URI.parse(location))
        else
          uri = location
        end
      end

      @rewritten = true
      @code = opts.fetch(:code, 301)
      @headers = {"Location" => uri.to_s}
      @body = []
    end
  end
end