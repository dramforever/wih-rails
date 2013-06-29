# == Schema Information
#
# Table name: images
#
#  id               :integer          not null, primary key
#  vote             :integer
#  win              :integer
#  rate             :float
#  img_file_name    :string(255)
#  img_content_type :string(255)
#  img_file_size    :integer
#  img_updated_at   :datetime
#  gender           :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Image < ActiveRecord::Base
  has_attached_file :img, :styles => { medium: "300x300>" }
  validates_attachment_presence :img
  validates_attachment_size :img, :less_than => 2.megabytes
  validates_attachment_content_type :img, :content_type => [ "image/jpg" ,"image/jpeg", "image/png", "image/gif" ]
end
