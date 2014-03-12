require 'spec_helper'

describe FbGraph::AdGroup, '.new' do
    attr_accessor :campaign_id, :name, :adgroup_status, :bid_type, :updated_time
  it 'should setup all supported attributes' do
    attributes = {
      :id => '6003590469668',
      :campaign_id => 6003590468467,
      :name => 'Ad Group 1',
      :adgroup_status => 1,
      :bid_type => 1,
      :updated_time => "2011-09-04T16:00:00+00:00",
      :view_tags => ["http://example.com"]
    }
    ad_group = FbGraph::AdGroup.new(attributes.delete(:id), attributes)
    ad_group.identifier.should == "6003590469668"
    ad_group.campaign_id.should == 6003590468467
    ad_group.name.should == "Ad Group 1"
    ad_group.adgroup_status.should == 1
    ad_group.bid_type.should == 1
    ad_group.updated_time.should == Time.parse("2011-09-04T16:00:00+00:00")
    ad_group.view_tags.should == ["http://example.com"]
  end
end


describe FbGraph::AdGroup, '.fetch' do
  it 'should get the ad group' do
    mock_graph :get, '6003590469668', 'ad_groups/test_ad_group', :access_token => 'access_token' do
      ad_group = FbGraph::AdGroup.fetch('6003590469668', :access_token => 'access_token')

      ad_group.identifier.should == "6003590469668"
      ad_group.campaign_id.should == 6003590468467
      ad_group.name.should == "Ad Group 1"
      ad_group.adgroup_status.should == 1
      ad_group.bid_type.should == 1
      ad_group.updated_time.should == Time.parse("2011-09-04T16:00:00+00:00")
      ad_group.view_tags.should == ["http://example.com"]
    end
  end
end

describe FbGraph::AdGroup, '.update' do
  context "without the redownload parameter" do
    it "should return true from facebook" do 
      mock_graph :post, '6003590469668', 'true', :name => 'Ad Group 1.1'  do
        attributes = {
          :id => '6003590469668',
          :name => 'Ad Group 1'
        }
        ad_group = FbGraph::AdGroup.new(attributes.delete(:id), attributes)
        ad_group.update(:name => 'Ad Group 1.1').should be_true

      end
    end
  end

  context "with the redownload parameter" do
    it "should update the AdGroup with the new data from facebook" do
      mock_graph :post, "6004165047777", 'ad_groups/test_ad_group_update_with_redownload', :adgroup_status => 4, :redownload => true do
        attributes = {
          :id => "6004165047777",
          :adgroup_status => 1
        }

        ad_group = FbGraph::AdGroup.new(attributes.delete(:id), attributes)
        ad_group.adgroup_status.should == 1

        ad_group.update(:adgroup_status => 4, :redownload => true)

        # Our test assumes that adgroup_status has changed on Facebook's side and is passed back different
        ad_group.adgroup_status.should == 4
      end
    end
  end
end
