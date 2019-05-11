# frozen_string_literal: true

module Discrepancies
  class Detector
    extend Callable

    def initialize(params = {})
      @file_path = params.fetch(:file_path, ENV['FILE_PATH'])
      @remote_url = params.fetch(:remote_url, ENV['REMOTE_URL'])
    end

    def call
      local = GetLocalCampaigns.call(@file_path)
      remote = GetRemoteCampaigns.call(@remote_url)
      CompareCampaigns.call(local_campaigns: local, remote_campaigns: remote)
    end
  end
end
