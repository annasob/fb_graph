module FbGraph
  module Connections
    module AdSets
      def ad_sets(options = {})
        ad_sets = self.connection :adcampaigns, options
        ad_sets.map! do |ad_set|
          AdSet.new ad_set[:id], ad_set.merge(
            :access_token => options[:access_token] || self.access_token
          )
        end
      end

      def ad_set!(options = {})
        ad_set = post options.merge(:connection => :adcampaigns)

        ad_set_id = ad_set[:id]

        merged_attrs = options.merge(
          :access_token => options[:access_token] || self.access_token
        )

        if options[:redownload]
          merged_attrs = merged_attrs.merge(ad_set[:data][:campaigns][ad_set_id]).with_indifferent_access
        end

        AdSet.new ad_set_id, merged_attrs
      end
    end
  end
end
