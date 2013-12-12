class Item < ActiveRecord::Base
  belongs_to :category
  has_many :pictures

  validates :name, presence: true
  validates :category_id, presence: true

  def icon
    self.pictures.blank? ? "icon.png" : self.pictures.first.image_url(:thumb)
  end
end
