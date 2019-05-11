# frozen_string_literal: true

require 'httparty'

module Discrepancies
  class GetRemoteCampaigns
    extend Callable

    def initialize(remote_url)
      @remote_url = remote_url
    end

    def call
      response = HTTParty.get(@remote_url)
      JSON.parse(response).fetch('ads') if response.code == 200
    rescue SocketError
      nil
    end
  end
end
