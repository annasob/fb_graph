module FbGraph
  module Connections
    module AdSetStats
      # When retrieving stats at the AdAccount level we use the 'adcampaignstats' connection
      # This returns an Array of statistics
      def ad_set_stats(options = {})
        ad_set_stats = self.connection :adcampaignstats, options
        ad_set_stats.map! do |ad_set_stat|
          AdSetStat.new ad_set_stat[:id], ad_set_stat.merge(
            :access_token => options[:access_token] || self.access_token
          )
        end
      end

      # Note: This could also be a connection on the AdSet model, but it has a different connection name
      # 'stats' instead of 'adcampaignstats'
      # In addition, it returns a single JSON response that does not conform to the standard connections 
      # array structure, making it difficult to parse with the underlying fb_graph Connection object.
    end
  end
end

