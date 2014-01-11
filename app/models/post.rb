class Post < ActiveRecord::Base

  belongs_to :user
  before_save :slugidize
  has_many :comments
  has_many :uploads


  validates_presence_of :title

  def next
    Post.where("created_at > ?", created_at).first
  end

  def last
    Post.where("created_at < ?", created_at).last
  end

  private

  def slugidize
    self.slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

end
