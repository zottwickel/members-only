class PostsController < ApplicationController

	before_action :logged_in_user, only: [:new, :create]

	def index
      @post  = Post.all.build
      @feed_items = Post.all.paginate(page: params[:page])
	end

	def show
		@post = Post.find(params[:id])
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash.now[:success] = "Post created!"
			redirect_to @post
		else
			flash.now[:danger] = "Unable to create post"
			render :new
		end
	end


	private################Private Methods#######################

	def logged_in_user
		unless logged_in?
			store_location
			flash.now[:danger] = "Please log in to make a post."
			redirect_to lgoin_url
		end
	end

	def post_params
		params.require(:post).permit(:subject, :body)
	end

end
