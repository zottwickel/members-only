class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		flash.now[:success] = "User successfully created"
  		redirect_to @user
  	else
  		render :new
  	end
  end

  private################private methods########################

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
  	unless logged_in?
  		store_location
  		flash.now[:danger] = "Please log in."
  		redirect_to login_url
  	end
  end

  def correct_user
  	@user = User.find(params[:id])
  	redirect_to(root_url) unless current_user?(@user)
  end

end
