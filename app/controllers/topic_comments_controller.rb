class TopicCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_topic

  def create
    @comment = @topic.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private
  def find_topic
    @topic = Topic.find(params[:topic_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
