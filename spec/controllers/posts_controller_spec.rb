require 'spec_helper'

#make a user and post factorygirl product

describe PostsController do

  describe "Get index" do

      it "should return a list of up to 8 posts" do
      end

  end 

  describe "GET new" do

    it "should return a post with an incremented id" do
    end

  end

  describe "POST create" do

    it "should create a post using params" do
    end

    it "should render new if post is not saved" do
    end

  end

  describe "GET show" do

    it "should retrieve a single post along with a new comment object by slug" do
    end

    it "should give a 404 if no post is found" do
    end

  end

  describe "PUT update" do

    it "should find and update a post" do
    end

    it "should render 'edit' if unable to update a post" do
    end

  end

  describe "DELETE destroy" do

    it "should delete a post by ID and redirect to admin index" do
    end

  end

  describe "GET feed" do

    it "should return an atom feed" do
    end
  end

end



