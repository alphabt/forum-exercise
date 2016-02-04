class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_topic, only: [:show, :subscribe, :unsubscribe]
  before_action :find_my_topic, only: [:edit, :update, :destroy]

  def index
    case params[:order]
    when 'newest_post'
      @topics = Topic.order('created_at DESC')
    when 'most_replies'
      @topics = Topic.eager_load(:comments).group('topics.id').order('count(comments.topic_id) DESC')
    else
      @topics = Topic.all
    end

    if params[:category]
      @category = Category.find( params[:category] )
      @topics = @category.topics
    end

    if params[:tag]
      tag = Tag.find_by_name(params[:tag])
      @topics = tag.topics
    end

    @topics = @topics.includes(:comments, :user, :category, :tags).page(params[:page])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user

    if @topic.save
      redirect_to topics_path
    else
      render :action => :new
    end
  end

  def show
    @comment = Comment.new

    unless cookies["view-topic-#{@topic.id}"]
      cookies["view-topic-#{@topic.id}"] = 'viewed'
      @topic.views_count += 1
      @topic.save!
    end
  end

  def edit
  end

  def update

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

  def subscribe
    @topic.subscriptions.create!(:user => current_user)

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def unsubscribe
    current_user.subscriptions.where(:topic => @topic).destroy_all

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'subscribe' }
    end
  end

  private

  def find_topic
    @topic = Topic.find(params[:id])
  end

  def find_my_topic
    @topic = current_user.topics.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title, :content, :category_id, :user_id, :image, :tag_list)
  end
end
