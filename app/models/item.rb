class Item < ActiveRecord::Base

  # Concerns
  include Ebayer

  belongs_to :category
  has_many :pictures

  validates :name, presence: true
  validates :category_id, presence: true

  state_machine :state, :initial => :new do
    state :new
    state :listed do
      validates :price, presence: true
      validate :post_to_ebay
    end
    state :sold
    state :shipped

    event :list do
      transition :new => :listed
    end
  end

  def icon
    self.pictures.blank? ? "icon.png" : self.pictures.first.image_url(:thumb)
  end
end
