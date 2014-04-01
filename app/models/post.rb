class Post < ActiveRecord::Base
  as_enum :post_type, blog_post: 0, blog_page: 1, blog_widget: 2

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

  class << self
    def by_title(title)
      Post.where(title: title).first
    end
  end

  private

  def slugidize
    unless self.blog_widget?
      self.slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end
  end

end
