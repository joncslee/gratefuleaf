class AddAttachmentPhotoToLeaves < ActiveRecord::Migration
  def self.up
    change_table :leaves do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :leaves, :photo
  end
end
