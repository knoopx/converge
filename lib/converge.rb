require 'converge/middleware'
require 'converge/rule'

module Converge
  class << self
    alias_method :configure, :instance_eval

    def rules
      @rules ||= []
    end

    def match(args, &block)
      rules << Rule.new(args, block)
    end

    def redirect(regex, location, opts = {})
      match(regex) { redirect(location, opts) }
    end
  end
end