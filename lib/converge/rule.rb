module Converge
  class Rule
    attr_reader :args, :block

    def initialize(args, block)
      @args, @block = args, block
    end

    def match(request)
      case args
        when String, Regexp
          simple_match(request, @args)
        when Hash
          advanced_match(request, @args)
        else
          raise ArgumentError("Match takes a String, Regexp or Hash of Rack::Request attributes as an argument")
      end
    end

    protected

    def value_match?(value, expected_value)
      if expected_value.is_a?(Regexp)
        if (matches = value.match(expected_value))
          matches[1..matches.size-1]
        else
          false
        end
      else
        value.eql?(expected_value)
      end
    end

    def simple_match(request, path)
      request.get? && value_match?(request.fullpath, path)
    end

    def advanced_match(request, components)
      components.all? { |key, expected_value| value_match?(request.send(key), expected_value) }
    end
  end
end