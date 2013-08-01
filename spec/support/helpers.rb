require 'active_support/concern'
require 'rack/mock'

module Helpers
  extend ActiveSupport::Concern

  module ClassMethods
    def rules(&block)
      before { Converge.rules.clear }
      let!(:rules) { Converge.configure(&block); Converge.rules }
    end
  end
end