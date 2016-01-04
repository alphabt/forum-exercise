class Subscription < ActiveRecord::Base
  validates_uniqueness_of :user_id, :scope => :topic_id

  belongs_to :topic
  belongs_to :user
end
