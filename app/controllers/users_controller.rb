class UsersController < ApplicationController
  
  def index
    @thing = 'soccer'
    fetch_users = Proc.new { Array.wrap(User.all) }
    @users = fetch_users.call
  end

  def create
    @user = User.new(params.require(:user).permit(:account_name))
    @user.save

    redirect_to @user
  end

  def update
  	byebug
  end

  def show
  	@user = User.find(params[:id])
  	@timeline = twitter.user_timeline(@user.account_name)
  end

  def edit
  	@user = User.find(params[:id])
  end
end