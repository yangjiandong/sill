# coding: UTF-8
class PostsController < ApplicationHtmlController

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
        format.html { redirect_to(posts_path, :notice => 'Post 创建成功。') }
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
        format.html { redirect_to(posts_path, :notice => 'Post 更新成功。') }
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
      format.html { redirect_to(posts_path,:notice => "删除成功。") }
      format.json
    end
  end

#= link_to 'Export to CSV', participants_path(:format => :csv)
  def export_csv
    @participants = Post.all

    respond_to do |format|
      format.csv {
        participants_csv = FasterCSV.generate do |csv|
        csv  ["First Name", "Last Name", "Age", "Gender", "Address", "Phone", "Email"]
        @participants.each do |p|
          csv  [p.first_name, p.last_name, p.age, p.gender, p.address, p.phone, p.email]
        end
        end
      send_data participants_csv, :type => 'text/csv', :filename => 'participants.csv'
      }
    end
  end
  #其中用FasterCSV快速创建好csv数据，再通过send_data发送给客户端就可以了

end
