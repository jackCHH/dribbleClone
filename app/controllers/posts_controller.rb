class PostsController < ApplicationController

	before_action :find_posts, only: [:show, :update, :edit, :destroy, :upvote, :downvote]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@posts = Post.all.order("CREATED_AT DESC")
	end

	def show
		@comments = Comment.where(post_id: @post)
		@random_post = Post.where.not(id: @post).order("RANDOM()").first

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

	# the following upvote and downvote are utilized in the routes.rb file
	def upvote
		@post.upvote_by current_user
		redirect_to :back
	end

	def downvote
		@post.downvote_by current_user
		redirect_to :back
	end

	private

	def post_params
		params.require(:post).permit(:image, :title, :link, :description)
	end

	def find_posts
		@post = Post.find(params[:id])
	end
end
