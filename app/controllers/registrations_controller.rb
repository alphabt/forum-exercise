class RegistrationsController < Devise::RegistrationsController
  before_action :find_topics
  before_action :find_comments

  private
  def find_topics
    @topics = Topic.where(:user_id => current_user.id)
  end

  def find_comments
    @comments = Comment.where(:user_id => current_user.id)
  end

  def sign_up_params
    params.require(:user).permit(:fullname, :username, :description, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:fullname, :username, :description, :email, :password, :password_confirmation, :current_password)
  end
end
