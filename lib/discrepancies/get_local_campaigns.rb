# frozen_string_literal: true

require 'json'

module Discrepancies
  class GetLocalCampaigns
    extend Callable

    def initialize(file_path)
      @file_path = file_path
    end

    def call
      data = File.open(@file_path) do |f|
        JSON.parse(f.read)
      end
      data.fetch('ads')
    end
  end
end
