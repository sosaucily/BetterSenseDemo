module VideosHelper

  def getAdCategories(keyword)
    logger.info "Looking for categories for keyword " + keyword

    if (keyword == "No Match") then return end

    wordResults = Array.new
    results = Array.new
    
    #First let's check if the exact matching word / phrase is in our wordTrie
    hitQuality = "Great"

    wordResults.push ($adWordTrie.wildcard (keyword.downcase))

    if (wordResults[0].empty?) then
      wordResults = []
      logger.info "in Very Good section, trying " + keyword.downcase + " ........."
      wordResults.push ($adWordTrie.wildcard(keyword.downcase + " .........."))
      logger.info "results are " + wordResults.to_s
      hitQuality = "Very Good"
    end

    if (wordResults[0].empty?) then
      wordResults = []
      keyword.to_s.split(" ").each do |word|
        wordResults.push ($adWordTrie.wildcard (word.downcase + " ........"))
      end
      hitQuality = "Good"
    end

    if (wordResults[0].empty?) then
      wordResults = []
      keyword.to_s.split(" ").each do |word|
        wordResults.push ($adWordTrie.wildcard (word.downcase + "........"))
      end
      hitQuality = "Fair"
    end

    if (wordResults[0].empty?) then return end #No ad categories for this keyword

    #wordResults.flatten!
    wordResults.each do |cat|
      cat.each do |word|
        logger.info "now getting categories for " + word
        cats = $adWordTrie.get(word)
        results.push (cats.each_with_index.map {|c,i| if (i!=cats.length-1) then c.to_s + "->" else c.to_s end })
      end
    end
    result_string = ""
    results.uniq.each do |cat|
      result_string += cat.to_s + " - "
    end
    result_string = result_string[0..-3]
    result_string += " -- Accuracy: " + hitQuality
    logger.info "Result = " + result_string
    return result_string
  end

end
