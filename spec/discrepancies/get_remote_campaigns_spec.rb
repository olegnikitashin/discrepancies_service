# frozen_string_literal: true

require 'spec_helper'

describe Discrepancies::GetRemoteCampaigns do
  vcr_options = { cassette_name: 'get_remote_campaigns' }

  describe '#call', vcr: vcr_options do
    let(:remote_url) { 'https://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df' }
    let(:result) do
      [
        { 'reference' => '1', 'status' => 'enabled', 'description' => 'Description for campaign 11' },
        { 'reference' => '2', 'status' => 'disabled', 'description' => 'Description for campaign 12' },
        { 'reference' => '3', 'status' => 'enabled', 'description' => 'Description for campaign 13' }
      ]
    end

    it 'gets campaigns from remote url' do
      expect(described_class.call(remote_url)).to eq(result)
    end
  end
end
