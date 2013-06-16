class Post < ActiveRecord::Base

  belongs_to :user
  before_save :slugidize
  has_many :comments

  validates_presence_of :title

  private

  def slugidize
    self.slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

end