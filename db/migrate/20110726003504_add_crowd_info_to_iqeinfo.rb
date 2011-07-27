class AddCrowdInfoToIqeinfo < ActiveRecord::Migration
  def self.up
    add_column :iqeinfos, :iqx, :integer
    add_column :iqeinfos, :iqy, :integer
    add_column :iqeinfos, :iqwidth, :integer
    add_column :iqeinfos, :iqheight, :integer
    add_column :iqeinfos, :cx, :integer
    add_column :iqeinfos, :cy, :integer
    add_column :iqeinfos, :cwidth, :integer
    add_column :iqeinfos, :xheight, :integer
    add_column :iqeinfos, :cradius, :integer
    add_column :iqeinfos, :send_to_crowd, :boolean, :default => false
    add_column :iqeinfos, :processing, :datetime, :default => Time.now
    add_column :iqeinfos, :complete, :boolean, :default => false
    add_column :iqeinfos, :cdescription, :string
    add_column :iqeinfos, :cproducturl, :string
    add_column :iqeinfos, :ccompanyurl, :string
  end

  def self.down
    remove_column :iqeinfos, :cdescription
    remove_column :iqeinfos, :cproducturl
    remove_column :iqeinfos, :ccompanyurl
    remove_column :iqeinfos, :complete
    remove_column :iqeinfos, :processing
    remove_column :iqeinfos, :send_to_crowd
    remove_column :iqeinfos, :xheight
    remove_column :iqeinfos, :cwidth
    remove_column :iqeinfos, :cy
    remove_column :iqeinfos, :cx
    remove_column :iqeinfos, :cradius
    remove_column :iqeinfos, :iqheight
    remove_column :iqeinfos, :iqwidth
    remove_column :iqeinfos, :iqy
    remove_column :iqeinfos, :iqx
  end
end
