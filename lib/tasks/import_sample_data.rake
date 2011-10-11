namespace :bettersense do
    desc "Used to import sample and configuration data into the database."
    task :load_bettersense_data => :environment do
      puts "Hello Rake!"
      data_to_create = YAML.load_file("#{Rails.root.to_s}/config/sample_data.yml")[Rails.env]
      data_to_create.keys.each do |object_name|
        data_to_create[object_name].each do |object_attrs|
          Object::const_get(object_name).new(object_attrs[1])
        end
      end
      zt = ZoneType.find_by_name("Video Overlay")
      z = Zone.find_by_name("Video Overlay (Text or Image)")
      z.zone_type_id = zt.id
      z.save
      
      z = Zone.find_by_name("Video Companion Skyscraper")
      z.zone_type_id = zt.id
      z.save
    end
end