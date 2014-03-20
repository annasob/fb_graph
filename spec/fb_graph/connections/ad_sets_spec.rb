require 'spec_helper'
describe FbGraph::Connections::AdSets, '#ad_set!' do
  context 'when included by FbGraph::AdAccount' do
    it 'should return generated ad_account' do
      mock_graph :post, 'act_22334455/adcampaigns', 'ad_accounts/ad_campaigns/post_with_valid_access_token' do
        ad_set = FbGraph::AdAccount.new('act_22334455', :access_token => 'valid').ad_set!(
          :name => "Campaign 1",
          :daily_budget => 500
        )

        ad_set.identifier.should == "6004167532222"
      end
    end

    it 'should handle the redownload parameter' do
      mock_graph :post, 'act_22334455/adcampaigns', 'ad_accounts/ad_campaigns/post_with_redownload' do
        ad_set = FbGraph::AdAccount.new('act_22334455', :access_token => 'valid').ad_set!(
          :name => "Campaign 1",
          :daily_budget => 500,
          :redownload => true
        )

        ad_set.identifier.should == "6004167532222"
        ad_set.account_id.should == 22334455
        ad_set.name.should == "Campaign 1"
        ad_set.daily_budget.should == 500
        ad_set.campaign_status.should == 2
        ad_set.daily_imps.should == 0
        ad_set.start_time.should == Time.at(1330282800)
        ad_set.end_time.should == Time.at(1330588800)
        ad_set.updated_time.should == Time.at(1329850926)
      end
    end
  end
end

