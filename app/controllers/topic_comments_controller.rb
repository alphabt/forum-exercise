class TopicCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_topic

  def create
    @comment = @topic.comments.build(comment_params)

    if @comment.save
      redirect_to @topic
    else
      render 'topics/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to @topic
  end

  private
  def find_topic
    @topic = Topic.find(params[:topic_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
