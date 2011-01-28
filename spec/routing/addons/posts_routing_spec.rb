require "spec_helper"

describe Addons::PostsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/addons_posts" }.should route_to(:controller => "addons_posts", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/addons_posts/new" }.should route_to(:controller => "addons_posts", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/addons_posts/1" }.should route_to(:controller => "addons_posts", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/addons_posts/1/edit" }.should route_to(:controller => "addons_posts", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/addons_posts" }.should route_to(:controller => "addons_posts", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/addons_posts/1" }.should route_to(:controller => "addons_posts", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/addons_posts/1" }.should route_to(:controller => "addons_posts", :action => "destroy", :id => "1")
    end

  end
end
