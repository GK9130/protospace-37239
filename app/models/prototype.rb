class Prototype < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :user
  has_many :comments
  
  has_one_attached :image

  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  validates :image, presence: true

  validates :content, presence: true, unless: :was_attached?

  def was_attached?
    self.image.attached?
  end

end
