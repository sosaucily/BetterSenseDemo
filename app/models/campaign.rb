class Campaign < ActiveRecord::Base

  has_many :ads, :dependent => :destroy

  def self.generatePerformance(campaigns)
    results = []
    campaigns.each { |c| 
      @ads = Ad.find_all_by_campaign_id(c.id)
      curr_camp = {
        :id => c.id,
        :total_ads => @ads.count,
        :total_clicks => @ads.inject(0) { |result,element| element.click_count.nil? ? result : result + element.click_count },
        :total_impressions => @ads.inject(0) { |result,element| element.impress_count.nil? ? result : result + element.impress_count }
      }
      results << curr_camp
    }
    results
  end
end
