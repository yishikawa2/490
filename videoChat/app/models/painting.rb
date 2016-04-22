class Painting < ActiveRecord::Base
  belongs_to :room
  mount_uploader :image, ImageUploader

  before_create :default_name

  def default_name
    self.name ||= image.filename if image
  end
end
