require 'spec_helper'

describe AdminsController do

  describe "GET index" do
    login_admin

    before(:each) do
      FactoryGirl.create_list(:post, 3)
    end

    it "should return a list of posts" do
      get :index
      response.should be_success
      assigns(:posts).sort.should eq(Post.all.sort)
    end

  end

  describe "GET show" do
    login_admin

    let(:post) { FactoryGirl.create(:post) }

    it "should retrieve a post by ID" do
      get :show, id: post.id
      response.should be_success
      assigns(:post).should eq(post)
    end

  end
end
