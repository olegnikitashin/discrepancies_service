# frozen_string_literal: true

module Discrepancies
  module Callable
    def call(*args)
      new(*args).call
    end
  end
end
