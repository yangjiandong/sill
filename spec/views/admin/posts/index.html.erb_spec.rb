require 'spec_helper'

describe "admin_posts/index.html.erb" do
  before(:each) do
    assign(:admin_posts, [
      stub_model(Admin::Post,
        :title => "Title",
        :body => "MyText",
        :user_id => 1
      ),
      stub_model(Admin::Post,
        :title => "Title",
        :body => "MyText",
        :user_id => 1
      )
    ])
  end

  it "renders a list of admin_posts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
