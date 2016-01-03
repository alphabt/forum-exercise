class Like < ActiveRecord::Base
  validates_uniqueness_of :user_id, :scope => :topic_id

  belongs_to :user
  belongs_to :topic
end
