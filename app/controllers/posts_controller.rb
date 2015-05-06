class PostsController < ApplicationController

	before_action :find_posts, only: [:show, :update, :edit, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@posts = Post.all.order("CREATED_AT DESC")
	end

	def show

	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end

	private

	def post_params
		params.require(:post).permit(:image, :title, :link, :description)
	end

	def find_posts
		@post = Post.find(params[:id])
	end
end
