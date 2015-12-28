class TopicsController < ApplicationController
  before_action :find_topic, only: [:show, :edit, :update, :destroy]

  def index
    case params[:order]
    when 'newest_post'
      @topics = Topic.order('created_at DESC').page(params[:page])
    when 'most_replies'
      @topics = Topic.eager_load(:comments).group('topics.id').order('count(comments.topic_id) desc').page(params[:page])
    else
      @topics = Topic.page(params[:page])
    end
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

  def show
    @comment = Comment.new
  end

  def edit
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.update(topic_params)

    if @topic.save
      redirect_to @topic
    else
      render :action => :edit
    end
  end

  def destroy
    @topic.destroy
    redirect_to topics_path
  end

  private
  def find_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title, :content)
  end
end
