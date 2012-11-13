require 'rexml/document'

class DemoVideoMetadata
  
  def initialize(hashstring, xml_data_file)
    #This is used to improve the viewer experience
    viewer_offset = 1
    
    video_report_dir = Rails.root.to_s + BetterSenseDemo::APP_CONFIG["report_directory"] + hashstring
    report_content = IO.read(video_report_dir + "/" + xml_data_file)#.html_safe
    doc = REXML::Document.new(report_content)
    root = doc.root
    @video_metadata = {:topVideoKeywords => [],:topVideoCategories => [],:scenes => {},:frames => {}}
    @video_metadata[:title] = root.elements['title'].text.strip
    @video_metadata[:videoName] = root.elements['videoName'].text.strip
    @video_metadata[:videoID] = root.elements['videoID'].text.strip
    ref_id = root.elements['referenceID'].text || ""
    @video_metadata[:referenceID] = ref_id.strip
    
    doc.elements.each('betterMetadata/topVideoKeywords/keyword') do |ele|
      @video_metadata[:topVideoKeywords] << {:keyword => ele.text.strip, :relevance => ele.attributes['relevance']}
    end
    
    doc.elements.each('betterMetadata/topVideoCategories/category') do |ele|
      @video_metadata[:topVideoCategories] << {:category => ele.text.strip, :relevance => ele.attributes['relevance']}
    end
    
    doc.elements.each('betterMetadata/scenes/scene') do |ele|
      scene_data = {:startTime => ele.elements['startTime'].text.strip, :stopTime => ele.elements['stopTime'].text.strip, :time => ele.attributes['time'], :keywords => [], :categories => []}
      ele.elements.each('topSceneKeywords/keyword') do |sub_ele|
        scene_data[:keywords] << {:keyword => sub_ele.text.strip, :relevance => sub_ele.attributes['relevance']}
      end
      ele.elements.each('topSceneCategories/category') do |sub_ele|
        scene_data[:categories] << {:category => sub_ele.text.strip, :relevance => sub_ele.attributes['relevance']}
      end
      @video_metadata[:scenes]["elem_" + string_to_seconds(ele.elements['startTime'].text.strip).to_s] = scene_data
    end
    
    doc.elements.each('betterMetadata/keywordByFrame/frame') do |ele|
      @video_metadata[:frames]["elem_" + (string_to_seconds(ele.attributes['time']) - viewer_offset).to_s] = { :keyword => ele.elements['keyword'].text.strip, :relevance => ele.elements['keyword'].attributes['relevance'], :time => ele.attributes['time'] }
    end
  end
  
  def string_to_seconds(time_string)
    ( (time_string[0...2].to_i * 3600) + (time_string[3...5].to_i * 60) + time_string[6...8].to_i )
  end
  
end