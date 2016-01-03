class Topic < ActiveRecord::Base
  validates :title, presence: true

  has_many :comments, :dependent => :destroy
  has_many :likes, :dependent => :destroy
  has_many :liked_topics, :through => :likes, :source => :topic
  belongs_to :category
  belongs_to :user

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def find_my_like(user)
    if user
      self.likes.where(:user_id => user.id).first
    else
      nil
    end
  end
end
