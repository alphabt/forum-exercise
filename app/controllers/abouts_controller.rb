class AboutsController < ApplicationController
  def show
    @user_count = User.all.count
    @topic_count = Topic.all.count
    @comment_count = Comment.all.count
  end
end
