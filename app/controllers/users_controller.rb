class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :followers, :followings]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to user_path, notice: 'Profile has been saved'
    else
      render :edit
    end
  end
  
  def followers
    @name = "is followed by"
    @user = User.find(params[:id])
    @followlist = @user.follower_users
    render 'show_follow'
  end
  
  def followings
    @name = "is following"
    @user = User.find(params[:id])
    @followlist = @user.following_users
    render 'show_follow'
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :location, :bio)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
