class Comment < ActiveRecord::Base

	belongs_to :post

	validates :email,
		:presence => :true,
		:format => { :with => /\A[A-Za-z0-9._-]+@[A-Za-z0-9-]+\.[A-Za-z0-9]+{2,4}\z/ }

	validates :body,
		:presence => :true


end