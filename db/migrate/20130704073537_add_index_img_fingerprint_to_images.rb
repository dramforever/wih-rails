class AddIndexImgFingerprintToImages < ActiveRecord::Migration
  def change
    add_index :images, :img_fingerprint
  end
end
