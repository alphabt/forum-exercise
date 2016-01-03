class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_topic

  def create
    Like.create!(:user => current_user, :topic => @topic)

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'like' }
    end
  end

  def destroy
    like = current_user.likes.find(params[:id])
    like.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'like' }
    end
  end

  private
  def find_topic
    @topic = Topic.find(params[:topic_id])
  end
end
