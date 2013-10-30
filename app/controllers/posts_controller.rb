class PostsController < ApplicationController

  before_filter :check_if_admin, only: [:new, :edit, :update, :destroy]

  def index
    # @posts = Post.where(published: true)
    @posts = Post.all

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

    respond_to do |format|
      if @post.errors.empty?
        format.html { redirect_to post_path(@post) }
        format.js   { render nothing: true }
      else
        format.html { render "edit" }
        format.js   {  }
      end
    end
  end

  # /posts/1 DELETE
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

  def publish
    ids = [*params[:post_ids]]
    Post.update_all({ published: true }, { id: ids })
    Post.update_all({ published: false }, "posts.id NOT IN (#{ ids.join(',') })")
    #flash[:success] = "Attribute 'published' was updated successfully in posts"

    respond_to do |format|
      format.html { redirect_to posts_path }
      format.json { head :no_content }
    end
  end

  private

    def check_if_admin
      authenticate_or_request_with_http_basic("NewsSystem") do |username, password|
        username == "admin" && password == "admin"
      end
    end

end
