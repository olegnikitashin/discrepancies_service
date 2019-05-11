# frozen_string_literal: true

module Discrepancies
  class CompareCampaigns
    extend Callable
    COMPARED_ATTRIBUTES = %w[status description].freeze

    def initialize(local_campaigns:, remote_campaigns:)
      @local_campaigns = local_campaigns
      @remote_campaigns = remote_campaigns
    end

    def call
      return [] unless local_campaigns&.any? && remote_campaigns&.any?

      local_campaigns.each_with_object([]) do |local_campaign, result|
        remote_campaign = find_remote_campaign(local_campaign)
        discrepancies = find_discrepancies(local_campaign, remote_campaign)
        result << discrepancy_campaign(local_campaign['reference'], discrepancies) if discrepancies.any?
      end
    end

    private

    attr_reader :local_campaigns, :remote_campaigns

    def find_remote_campaign(local_campaign)
      remote_campaigns.find do |remote_campaign|
        remote_campaign['reference'].to_i == local_campaign['reference'].to_i
      end
    end

    def find_discrepancies(local_campaign, remote_campaign)
      return [] unless remote_campaign

      COMPARED_ATTRIBUTES.each_with_object([]) do |attr, result|
        if local_campaign[attr] != remote_campaign[attr]
          result << discrepancy(local_campaign[attr], remote_campaign[attr])
        end
      end
    end

    def discrepancy(local_value, remote_value)
      {
        'local' => local_value,
        'remote' => remote_value
      }
    end

    def discrepancy_campaign(id, discrepancies)
      {
        'remote_reference' => id,
        'discrepanciens' => discrepancies
      }
    end
  end
end
