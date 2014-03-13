module FbGraph
  class AdCampaign < Node
    include Connections::AdSets

    attr_accessor :id, :name, :objective, :campaign_group_status

    def initialize(identifier, attributes = {})
      super
      set_attrs(attributes)
    end

    protected

    def set_attrs(attributes)
      [:name, :objective, :campaign_group_status].each do |field|
        send("#{field}=", attributes[field.to_sym])
      end
    end
  end
end
