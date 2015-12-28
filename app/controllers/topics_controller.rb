class TopicsController < ApplicationController
  def index
    @topics = Topic.page(params[:page])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      redirect_to topics_path
    else
      render :action => :new
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:title, :content)
  end
end
