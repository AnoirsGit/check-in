require 'rails_helper'

RSpec.describe "tweets/edit", type: :view do
  before(:each) do
    @tweet = assign(:tweet, Tweet.create!(
      body: "MyString",
      likes: 1,
      retweets: 1
    ))
  end

  it "renders the edit tweet form" do
    render

    assert_select "form[action=?][method=?]", tweet_path(@tweet), "post" do

      assert_select "input[name=?]", "tweet[body]"

      assert_select "input[name=?]", "tweet[likes]"

      assert_select "input[name=?]", "tweet[retweets]"
    end
  end
end
