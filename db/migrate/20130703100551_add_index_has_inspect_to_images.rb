class AddIndexHasInspectToImages < ActiveRecord::Migration
  def change
    add_index :images, :has_inspect
  end
end
