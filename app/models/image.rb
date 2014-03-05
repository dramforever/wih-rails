# == Schema Information
#
# Table name: images
#
#  id          :integer          not null, primary key
#  vote        :integer
#  win         :integer
#  rate        :float
#  gender      :integer
#  created_at  :datetime
#  updated_at  :datetime
#  has_inspect :boolean
#  img         :string(255)
#

class Image < ActiveRecord::Base
  before_save :default_values
  has_attached_file :img, :styles => { medium: Proc.new { |instance| instance.resize }, large: "800x800>" }

  validates_attachment_presence :img
  validates_attachment_size :img, :less_than => 10.megabytes
  validates_attachment_content_type :img, :content_type => [ "image/jpg" ,"image/jpeg", "image/png" ]
  validates_uniqueness_of :img_fingerprint

  def resize
    geo = Paperclip::Geometry.from_file(img.queued_for_write[:original])
    if geo.width > geo.height
      '480x320#'    # Horizontal Image
    else
      '320x480#'    # Vertical Image
    end
  end

  private
  def default_values
    self.vote ||= 0
    self.win  ||= 0
    self.rate ||= 0
    self.has_inspect ||= false
    true
  end
end
