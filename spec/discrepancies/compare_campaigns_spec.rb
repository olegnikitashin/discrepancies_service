# frozen_string_literal: true

require 'spec_helper'

describe Discrepancies::CompareCampaigns do
  describe '#call' do
    let(:no_discrepancies) { [] }
    let(:no_campaigns) { [] }
    let(:local_campaigns) do
      [
        { 'reference' => '1', 'status' => 'enabled', 'description' => 'Description for campaign 11' },
        { 'reference' => '2', 'status' => 'disabled', 'description' => 'Description for campaign 12' },
        { 'reference' => '3', 'status' => 'enabled', 'description' => 'Description for campaign 13' }
      ]
    end
    let(:remote_campaigns) do
      [
        { 'reference' => '1', 'status' => 'disabled', 'description' => 'Campaign 41' },
        { 'reference' => '2', 'status' => 'disabled', 'description' => 'Campaign 22' },
        { 'reference' => '3', 'status' => 'enabled', 'description' => 'Description for campaign 13' }
      ]
    end
    let(:discrepancies) do
      [
        {
          'remote_reference' => '1', 'discrepanciens' =>
          [
            { 'local' => 'enabled', 'remote' => 'disabled' },
            { 'local' => 'Description for campaign 11', 'remote' => 'Campaign 41' }
          ]
        },
        {
          'remote_reference' => '2', 'discrepanciens' =>
          [{ 'local' => 'Description for campaign 12', 'remote' => 'Campaign 22' }]
        }
      ]
    end

    it 'returns no discrepancies if no campaigns' do
      expect(described_class.call(local_campaigns: no_campaigns, remote_campaigns: no_campaigns)).to eq(no_discrepancies)
    end

    it 'returns no discrepancies if campaigns do not differ' do
      expect(described_class.call(local_campaigns: local_campaigns, remote_campaigns: local_campaigns)).to eq(no_discrepancies)
    end

    it 'returns discrepancies if campaigns differ' do
      expect(described_class.call(local_campaigns: local_campaigns, remote_campaigns: remote_campaigns)).to eq(discrepancies)
    end
  end
end
