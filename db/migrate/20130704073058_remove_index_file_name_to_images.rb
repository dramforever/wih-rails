class RemoveIndexFileNameToImages < ActiveRecord::Migration
  def change
    remove_index :images, :img_file_name
  end
end
