require 'spec_helper'

describe FbGraph::Connections::AdSetStats, '#ad_set_stats' do
  context 'when included by FbGraph::AdAccount' do
    context 'when access_token is given' do
      it 'should return ad_set_stats as FbGraph::AdSetStats' do
        mock_graph :get, 'act_11223344/adcampaignstats', 'ad_accounts/ad_campaign_stats/test_ad_campaign_stats', :access_token => 'access_token' do
          ad_set_stats = FbGraph::AdAccount.new('act_11223344', :access_token => 'access_token').ad_set_stats

          ad_set_stats.size.should == 2
          ad_set_stats.each { |ad_set_stat| ad_set_stat.should be_instance_of(FbGraph::AdSetStat) }
          ad_set_stats.first.should == FbGraph::AdSetStat.new(
            "6002647797777/stats/0/1315507793",
            :campaign_id => 6002647797777,
            :start_time => nil,
            :end_time => Time.parse("2011-09-08T18:49:53+0000"),
            :impressions => 232641,
            :clicks => 534,
            :spent => 18885,
            :social_impressions => 22676,
            :social_clicks => 81,
            :social_spent => 1548,
            :unique_impressions => 0,
            :social_unique_impressions => 0,
            :unique_clicks => 0,
            :social_unique_clicks => 0,
            :actions => 140,
            :connections => 0,
            :access_token => 'access_token'
          )
        end
      end
    end
  end
end
