# frozen_string_literal: true

require 'spec_helper'

describe Discrepancies::Detector do
  vcr_options = { cassette_name: 'get_remote_campaigns' }

  describe '#call', vcr: vcr_options do
    let(:campaigns) { './spec/fixtures/campaigns.json' }
    let(:campaigns_with_diff) { './spec/fixtures/campaigns_with_diff.json' }
    let(:remote_url) { 'https://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df' }
    let(:no_discrepancies) { [] }
    let(:discrepancies) do
      [
        {
          'remote_reference' => '2', 'discrepanciens' =>
          [
            { 'local' => 'enabled', 'remote' => 'disabled' },
            { 'local' => 'Campaign 22', 'remote' => 'Description for campaign 12' }
          ]
        },
        {
          'remote_reference' => '3', 'discrepanciens' =>
          [{ 'local' => 'Campaign 13', 'remote' => 'Description for campaign 13' }]
        }
      ]
    end

    it 'returns no discrepancies if campaigns do not differ' do
      expect(described_class.call(file_path: campaigns, remote_url: remote_url)).to eq(no_discrepancies)
    end

    it 'returns discrepancies if campaigns differ' do
      expect(described_class.call(file_path: campaigns_with_diff, remote_url: remote_url)).to eq(discrepancies)
    end
  end
end
