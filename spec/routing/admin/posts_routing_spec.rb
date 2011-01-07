require "spec_helper"

describe Admin::PostsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin_posts" }.should route_to(:controller => "admin_posts", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin_posts/new" }.should route_to(:controller => "admin_posts", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin_posts/1" }.should route_to(:controller => "admin_posts", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin_posts/1/edit" }.should route_to(:controller => "admin_posts", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin_posts" }.should route_to(:controller => "admin_posts", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin_posts/1" }.should route_to(:controller => "admin_posts", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin_posts/1" }.should route_to(:controller => "admin_posts", :action => "destroy", :id => "1")
    end

  end
end
