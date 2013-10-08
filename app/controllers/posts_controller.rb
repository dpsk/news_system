class PostsController < ApplicationController

  before_filter :check_if_admin, only: [:new, :edit, :update, :destroy]

  def index
    @posts = Post.where(published: true)

    # render text: @posts.map { |p| "#{p.id} | #{p.body}" }.join("<br/>")
  end

  # /posts/1 GET
  def show
    @post = Post.where(id: params[:id]).first

    # render "posts/show"
  end

  # /posts/new GET
  def new
    @post = Post.new
  end

  # /posts/1/edit GET
  def edit
    @post = Post.find(params[:id])
  end

  # /posts POST
  def create
    @post = Post.create(params[:post])

    if @post.errors.empty?
      redirect_to post_path(@post)
    else
      render "new"
    end
  end

  # /posts/1 PUT
  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])

    if @post.errors.empty?
      redirect_to post_path(@post)
    else
      render "edit"
    end
  end

  # /posts/1 DELETE
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

  private

    def check_if_admin
      authenticate_or_request_with_http_basic("NewsSystem") do |username, password|
        username == "admin" && password == "admin"
      end
    end

end
