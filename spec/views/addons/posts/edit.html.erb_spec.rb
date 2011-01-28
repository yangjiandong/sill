require 'spec_helper'

describe "addons_posts/edit.html.erb" do
  before(:each) do
    @post = assign(:post, stub_model(Addons::Post,
      :title => "MyString"
    ))
  end

  it "renders the edit post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => post_path(@post), :method => "post" do
      assert_select "input#post_title", :name => "post[title]"
    end
  end
end
