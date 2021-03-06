class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]

  def index
    if logged_in?
      @users = User.all.paginate(page: params[:page])
    else
      flash[:danger] = "Log in to access this feature."
      redirect_to login_url
    end
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
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
