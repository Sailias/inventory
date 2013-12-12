class Picture < ActiveRecord::Base
  belongs_to :item

  mount_uploader :image, ImageUploader

  validates :image, presence: true
end
