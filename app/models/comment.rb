class Comment < ActiveRecord::Base
  validates :content, presence: true

  belongs_to :topic
  belongs_to :user
end
