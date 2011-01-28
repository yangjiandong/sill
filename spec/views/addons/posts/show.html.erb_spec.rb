require 'spec_helper'

describe "addons_posts/show.html.erb" do
  before(:each) do
    @post = assign(:post, stub_model(Addons::Post,
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
  end
end
