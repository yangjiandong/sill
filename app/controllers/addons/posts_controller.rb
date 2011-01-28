# coding: UTF-8
class Addons::PostsController < ApplicationController
  skip_before_filter :check_authentication
  #ApplicationHtmlController

  def index_json
    @datas = Addons::Post.find(:all)
    #debug_log("category,datas:" + @datas.to_json)

    render :json => {
        :rows => @datas,
        :results => @datas.count
        }, :layout => false
  end

  def index
    @posts = initialize_grid(Post, 
      :order => 'id',
      :order_direction => 'desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json
    end
  end

  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json
    end
  end
  
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to(addons_posts_path, :notice => 'Post 创建成功。') }
        format.json
      else
        format.html { render :action => "new" }
        format.json
      end
    end
  end
  
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(addons_posts_path, :notice => 'Post 更新成功。') }
        format.json
      else
        format.html { render :action => "edit" }
        format.json
      end
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(addons_posts_path,:notice => "删除成功。") }
      format.json
    end
  end
end
