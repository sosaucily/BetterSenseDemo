class Iqeinfo < ActiveRecord::Base
  belongs_to :video
  belongs_to :ads

  scope :ordered, lambda {|*args| {:order => (args.first || 'created_at DESC')} }
  
  def self.getJSONForCrowd(images)
    keys = ['id','imagepath']
    crowd_data = images.inject([]) do |result,element|
      my_result = Hash[*element.attributes.select {|key,value| keys.include?(key) }.flatten]
      my_result["imagepath"] = BetterSenseDemo::APP_CONFIG["base_url"] + my_result["imagepath"]
      result << {"iqeinfo"=>my_result}
    end
    crowd_data
  end

end
