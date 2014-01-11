require 'spec_helper'

describe CommentsController do

  describe "POST create" do
    let(:blog_post) { FactoryGirl.create(:post) }

    it "should only create a comment with the right field value" do
      expect do
        post :create, { post_id: blog_post.id,
                        comment: FactoryGirl.attributes_for(:comment).merge(name: "frodolives") }
      end.to change { Comment.count }.by(1)
    end

    it "should increase a post spam count field if lack of frodo" do
      post :create, { post_id: blog_post.id,
                        comment: FactoryGirl.attributes_for(:comment) }
      blog_post.reload
      blog_post.spam_count.should eq(1)
    end

  end

  describe "DELETE destroy" do
    login_admin
    before(:each) do
      @post = FactoryGirl.create(:post, :with_comments)
      @comment = @post.comments.first
    end

    it "should delete a comment when supplied with an id" do
      expect do
        delete :destroy, post_id: @post.id, id: @comment.id
      end.to change { Comment.count }.by(-1)
    end

  end

end
