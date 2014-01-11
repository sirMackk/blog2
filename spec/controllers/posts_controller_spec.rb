require 'spec_helper'

#make a user and post factorygirl product

describe PostsController do

  describe "Get index" do
    before(:each) do
      FactoryGirl.create_list(:post, 10)
    end


    it "should return a list of up to 8 posts" do
      get :index
      response.should be_success
      assigns(:posts).size.should eq(8)
    end

  end 

  describe "GET new" do
    login_admin

    it "should return a post with an incremented id" do
      get :new
      response.should be_success
      assigns(:post).id.should eq(0)
    end

  end

  describe "POST create" do
    login_admin

    it "should create a post using params" do
      expect do
        post :create, post: FactoryGirl.attributes_for(:post)
        response.should be_redirect
      end.to change { Post.count }.by(1)
    end

    it "should render new if post is not saved" do
      post :create, post: FactoryGirl.attributes_for(:post, title: nil)
      response.should be_success
    end

  end

  describe "GET show" do
    let(:post) { FactoryGirl.create(:post) }

    it "should retrieve a single post along with a new comment object by slug" do
      get :show, slug: post.slug
      response.should be_success
      assigns(:post).should eq(post)
    end

    it "should give a 404 if no post is found" do
      get :show, slug: 'nope'
      response.status.should eq(404)
    end

  end

  describe "PUT update" do
    login_admin
    let(:blog_post) { FactoryGirl.create(:post) }

    it "should find and update a post" do
      put :update, id: blog_post.id, post: { title: "Changed!" } 
      blog_post.reload
      blog_post.title.should eq("Changed!")
      response.should be_redirect
    end

    it "should render 'edit' if unable to update a post" do
      put :update, id: blog_post.id, post: { title: nil }
      response.should be_success
    end

  end

  describe "DELETE destroy" do
    login_admin
    before(:each) { @post = FactoryGirl.create(:post) }

    it "should delete a post by ID and redirect to admin index" do
      expect do
        delete :destroy, id: @post.id
        response.should be_redirect
      end.to change { Post.count }.by(-1)
    end

  end

  describe "GET feed" do
    before(:each) do
      FactoryGirl.create_list(:post, 3)
    end

    it "should return an atom feed" do
      get :feed, format: :atom
      response.should be_success
      assigns(:posts).sort.should eq(Post.all.sort)
    end

    it "should redirect for rss" do
      get :feed, format: :rss
      response.should redirect_to(feed_path)
    end
  end

end



