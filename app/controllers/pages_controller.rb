class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :redirect ]

  def home
    if user_signed_in?
      redirect_to user_path(current_user)
    end
  end

  def redirect
    @search = Search.find(params['format'])
  end
end
