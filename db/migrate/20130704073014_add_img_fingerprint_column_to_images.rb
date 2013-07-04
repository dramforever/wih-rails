class AddImgFingerprintColumnToImages < ActiveRecord::Migration
  def change
    add_column :images, :img_fingerprint, :string
  end
end
