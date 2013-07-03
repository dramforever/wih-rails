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
  before_save :default_values
  has_attached_file :img, :styles => { medium: Proc.new { |instance| instance.resize }, large: "800x800>" }

  validates_attachment_presence :img
  validates_attachment_size :img, :less_than => 5.megabytes
  validates_attachment_content_type :img, :content_type => [ "image/jpg" ,"image/jpeg", "image/png", "image/gif" ]

  def resize
    geo = Paperclip::Geometry.from_file(img.queued_for_write[:original])
    if geo.width > geo.height
      '480x320>'    # Horizontal Image
    else
      '320x480>'    # Vertical Image
    end
  end

  private
  def default_values
    self.vote ||= 0
    self.win  ||= 0
    self.rate ||= 0
  end
end
