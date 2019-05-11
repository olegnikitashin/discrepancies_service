# frozen_string_literal: true

require 'spec_helper'

describe Discrepancies::GetLocalCampaigns do
  describe '#call' do
    let(:file_path) { './spec/fixtures/campaigns.json' }
    let(:result) do
      [
        { 'reference' => '1', 'status' => 'enabled', 'description' => 'Description for campaign 11' },
        { 'reference' => '2', 'status' => 'disabled', 'description' => 'Description for campaign 12' },
        { 'reference' => '3', 'status' => 'enabled', 'description' => 'Description for campaign 13' }
      ]
    end

    it 'gets campaigns from local file' do
      expect(described_class.call(file_path)).to eq(result)
    end
  end
end
