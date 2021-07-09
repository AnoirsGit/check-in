require 'rails_helper'

RSpec.describe "tweets/new", type: :view do
  before(:each) do
    assign(:tweet, Tweet.new(
      body: "MyString",
      likes: 1,
      retweets: 1
    ))
  end

  it "renders new tweet form" do
    render

    assert_select "form[action=?][method=?]", tweets_path, "post" do

      assert_select "input[name=?]", "tweet[body]"

      assert_select "input[name=?]", "tweet[likes]"

      assert_select "input[name=?]", "tweet[retweets]"
    end
  end
end
