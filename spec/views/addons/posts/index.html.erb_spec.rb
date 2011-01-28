require 'spec_helper'

describe "addons_posts/index.html.erb" do
  before(:each) do
    assign(:addons_posts, [
      stub_model(Addons::Post,
        :title => "Title"
      ),
      stub_model(Addons::Post,
        :title => "Title"
      )
    ])
  end

  it "renders a list of addons_posts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
