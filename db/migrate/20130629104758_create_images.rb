class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :vote
      t.integer :win
      t.float :rate
      t.attachment :img
      t.integer :gender

      t.timestamps
    end
  end
end
