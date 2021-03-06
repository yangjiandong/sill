require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe Addons::PostsController do

  def mock_post(stubs={})
    @mock_post ||= mock_model(Addons::Post, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all addons_posts as @addons_posts" do
      Addons::Post.stub(:all) { [mock_post] }
      get :index
      assigns(:addons_posts).should eq([mock_post])
    end
  end

  describe "GET show" do
    it "assigns the requested post as @post" do
      Addons::Post.stub(:find).with("37") { mock_post }
      get :show, :id => "37"
      assigns(:post).should be(mock_post)
    end
  end

  describe "GET new" do
    it "assigns a new post as @post" do
      Addons::Post.stub(:new) { mock_post }
      get :new
      assigns(:post).should be(mock_post)
    end
  end

  describe "GET edit" do
    it "assigns the requested post as @post" do
      Addons::Post.stub(:find).with("37") { mock_post }
      get :edit, :id => "37"
      assigns(:post).should be(mock_post)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created post as @post" do
        Addons::Post.stub(:new).with({'these' => 'params'}) { mock_post(:save => true) }
        post :create, :post => {'these' => 'params'}
        assigns(:post).should be(mock_post)
      end

      it "redirects to the created post" do
        Addons::Post.stub(:new) { mock_post(:save => true) }
        post :create, :post => {}
        response.should redirect_to(addons_post_url(mock_post))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved post as @post" do
        Addons::Post.stub(:new).with({'these' => 'params'}) { mock_post(:save => false) }
        post :create, :post => {'these' => 'params'}
        assigns(:post).should be(mock_post)
      end

      it "re-renders the 'new' template" do
        Addons::Post.stub(:new) { mock_post(:save => false) }
        post :create, :post => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested post" do
        Addons::Post.stub(:find).with("37") { mock_post }
        mock_addons_post.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :post => {'these' => 'params'}
      end

      it "assigns the requested post as @post" do
        Addons::Post.stub(:find) { mock_post(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:post).should be(mock_post)
      end

      it "redirects to the post" do
        Addons::Post.stub(:find) { mock_post(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(addons_post_url(mock_post))
      end
    end

    describe "with invalid params" do
      it "assigns the post as @post" do
        Addons::Post.stub(:find) { mock_post(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:post).should be(mock_post)
      end

      it "re-renders the 'edit' template" do
        Addons::Post.stub(:find) { mock_post(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested post" do
      Addons::Post.stub(:find).with("37") { mock_post }
      mock_addons_post.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the addons_posts list" do
      Addons::Post.stub(:find) { mock_post }
      delete :destroy, :id => "1"
      response.should redirect_to(addons_posts_url)
    end
  end

end
