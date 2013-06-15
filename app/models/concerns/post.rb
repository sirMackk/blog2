class Post < ActiveRecord::Base

  belongs_to :user

  validate_presence_of :title

end