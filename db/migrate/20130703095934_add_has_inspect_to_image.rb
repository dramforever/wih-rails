class AddHasInspectToImage < ActiveRecord::Migration
  def change
    add_column :images, :has_inspect, :boolean
    add_index :images, :gender
    add_index :images, :rate
  end
end
