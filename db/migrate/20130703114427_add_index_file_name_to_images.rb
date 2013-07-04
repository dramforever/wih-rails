class AddIndexFileNameToImages < ActiveRecord::Migration
  def change
    add_index :images, :img_file_name
  end
end
