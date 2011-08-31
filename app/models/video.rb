class Video < ActiveRecord::Base
  has_many :iqeinfos
  belongs_to :account
#  def self.save(upload)
#    name =  upload['datafile'].original_filename
#    directory = "videoData/videos/"
#    path = File.join(directory, name)
#    File.open (path,"wb") { |f| f.write(upload['datafile'].read) }
#  end
end
