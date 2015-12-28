class Topic < ActiveRecord::Base
  validates :title, presence: true

  has_many :comments, :dependent => :destroy
  belongs_to :category
end
