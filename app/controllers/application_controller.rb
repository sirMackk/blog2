class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :load_widgets

  def not_found
    raise ActionController::RoutingError.new("Not found")
  end

  def load_widgets
    @footer = Rails.cache.fetch('footer_widget', expires_in: 24.hours) do
      Post.by_title("footer") || Post.new(body: '')
    end
  end
  
end
