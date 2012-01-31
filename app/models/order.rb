class Order < ActiveRecord::Base

  has_many :line_items
  belongs_to :account
  
  def analyze_videos
    line_items.each do |item|
      item.video.do_analyze(item.quality)
    end
  end
  
end