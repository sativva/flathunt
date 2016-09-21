class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :initialize_search

  def initialize_search
    @search = Search.new
  end
end
