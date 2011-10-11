class Keyword

  def self.populateAdWordTrie()
    if (defined?($adWordTrie)) then return end
    $adWordTrie = Containers::Trie.new
    @dir = Rails.root.to_s + BetterSenseDemo::APP_CONFIG["keyword_data_dir"]
    files = Dir.entries(@dir)
    Rails.logger.info "Building ad word trie " + $adWordTrie.to_s

    files.each do |file|
      if (file.index(".csv") != nil) then
        categories = file.split("_")
        categories.map!{|item| if (item.index(".csv") != nil) then item[0..-5] else item end}
        FasterCSV.foreach(@dir + "/" + file,  :col_sep =>',', :row_sep =>:auto) do |row|
          $adWordTrie.push(row[0],categories)
          #Rails.logger.debug "pushing value " + row[0].to_s
        end
        Rails.logger.info "completed with file --" + file + "-- and categories " + categories.count.to_s
      end
    end
  end

end
