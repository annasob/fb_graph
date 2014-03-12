require 'spec_helper'

describe FbGraph::Connections::AdGroups, '#ad_groups' do
  context 'when included by FbGraph::AdCampaign' do
    context 'when access_token is given' do
      it 'should return ad_groups as FbGraph::AdGroup' do
        mock_graph :get, '22334455/adgroups', 'ad_campaigns/ad_groups/22334455_ad_groups', :access_token => 'access_token' do
          ad_groups = FbGraph::AdCampaign.new('22334455', :access_token => 'access_token').ad_groups
          ad_groups.size.should == 2
          ad_groups.each { |ad_group| ad_group.should be_instance_of(FbGraph::AdGroup) }
          ad_groups.first.should == FbGraph::AdGroup.new(
            "6003570493888",
            :access_token => 'access_token',
            :campaign_id => 22334455,
            :name => "My Ad 1",
            :adgroup_status => 1,
            :bid_type => 1,
            :updated_time => Time.parse("2011-08-17T20:41:39+0000"),
            :bid_info => {"1" => "120"},
            :creative_ids => [6003570493444],
            :targeting => {
              "age_min" => 18,
              "age_max" => 65,
              "countries" => ["US"],
              "education_statuses" => [3],
              "college_networks" => [
                {"name" => "Emory", "id" => "16777243"},
                {"name" => "Georgia Tech", "id" => "16777345"}
              ]
            }
          )
        end
      end
    end
  end
end

describe FbGraph::Connections::AdGroups, '#ad_group!' do
  context 'when included by FbGraph::AdAccount' do
    it 'should return generated ad_group' do
      mock_graph :post, 'act_22334455/adgroups', 'ad_accounts/ad_groups/post_with_valid_access_token' do
        ad_group = FbGraph::AdAccount.new('act_22334455', :access_token => 'valid').ad_group!(
          :name => "Test Ad 1",
          :campaign_id => 66778899,
          :bid_type => 1,
          :start_time => Time.parse("2011-09-10T12:00:00+00:00"),
          :end_time => Time.parse("2011-09-20T16:00:00-04:00")
        )

        ad_group.identifier.should == 112233445566
        ad_group.campaign_id.should == 66778899
        ad_group.name.should == "Test Ad 1"
        ad_group.bid_type.should == 1
      end
    end

    it 'should handle the redownload parameter' do
      mock_graph :post, 'act_22334455/adgroups', 'ad_accounts/ad_groups/post_with_redownload' do
        ad_group = FbGraph::AdAccount.new('act_22334455', :access_token => 'valid').ad_group!(
          :name => "Test Ad 2",
          :campaign_id => 11223344,
          :bid_type => 1,
          :redownload => true
        )

        ad_group.identifier.should == "22334455"
        ad_group.campaign_id.should == 11223344
        ad_group.name.should == "Test Ad 2"
        ad_group.bid_type.should == 1

        # ad_status is not sent, only received
        ad_group.adgroup_status.should == 4
      end
    end
  end
end

