class SearchesController < ApplicationController
  # before_action :set_user
  before_action :set_search, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [ :new, :create ]


  def index
    @searches = Search.all
  end

  def define_mail_agency
    @search = Search.find(params['search_id'])
  end

  def mail_agency
    @count = 0
    @search = Search.find(params['search_id'])
    if @search.location.split(',').length >=2
      @search.location.split(',').each do |p|
        Agency.where(postal: p).each do |agency|
          if AgencyMailer.newsearch(agency, @search, @user).deliver_now
            @count += 1
          end
        end
      end
    else
      Agency.where(postal: @search.location).each do |agency|
        if AgencyMailer.newsearch(agency, @user, @search, ).deliver_now
          @count += 1
        end
      end
    end
    redirect_to user_search_path(@user, @search), notice: @count.to_s + ' mails was successfully sent.'
  end

  def show
    @announces = Announce.where(search_id: @search).reverse
    @partner_links = set_partner_links
  end

  def new
    if session[:form_data]
      Search.create(session[:form_data]['search'])
      redirect_to root_path, notice: 'La recherche a correctement été crée. Nous revenons vers vous très rapidement. '
    else
      @search = Search.new
      @user = User.find(current_user)
    end
  end

  def edit
  end

  def create
    if current_user.nil?
      @search = Search.new(search_params)
      @search.floor = params['search']['floor'].join(',').strip.gsub(/^,/, "")
      @search.location = params['search']['location'].join(',').strip.gsub(/^,/, "")
      @search.option = params['search']['option'].join(',').strip.gsub(/^,/, "")
      if @search.save
        cookies[:search_id] = {
              :value => @search.id,
              :expires => 1.year.from_now
            }
        redirect_to redirect_path(@search)
      else
        redirect_to root_path
      end
      cookies[:search_id] = {
            :value => 'a yummy cookie',
            :expires => 1.year.from_now,
            :domain => 'domain.com'
          }

    else
      @search = Search.new(search_params)
      @search.user_id = current_user.id
      @search.floor = params['search']['floor'].join(',').strip.gsub(/^,/, "") if params['search']['floor']
      @search.location = params['search']['location'].join(',').strip.gsub(/^,/, "") if params['search']['location']
      @search.option = params['search']['option'].join(',').strip.gsub(/^,/, "") if params['search']['option']
      respond_to do |format|
        if @search.save

          format.html {
            if user_signed_in?
              redirect_to user_search_url(current_user, @search), notice: 'Search was successfully created.'
            else
              redirect_to root_path, notice: 'La recherche a correctement été crée. Nous revenons vers vous très rapidement. '
            end
            }
          format.json { render :show, status: :created, location: @search }
        else
          format.html { render :new }
          format.json { render json: @search.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @search.update(search_params_update)
        format.html { redirect_to user_search_url(current_user), notice: 'Search was successfully updated.' }
        format.json { render :show, status: :ok, location: @search }
      else
        format.html { render :edit }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to user_searches_url(current_user), notice: 'Search was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_search
    @search = Search.find(params[:id])
  end
  def set_user
    @user = User.find(current_user)
  end

  def search_params
    params.require(:search).permit(:price, :email, :username, :user_id, :lift, :surface, :room, :bedroom, :to_renovate, :comment, :option, location: [], floor: [])
  end

  def search_params_update
    if !params['search'].nil?
      if !@search.floor.nil? && !params['search']['floor'].nil?
        @search.floor = params['search']['floor'].join(',').strip.gsub(/^,/, "")
      end
      if !@search.location.nil? && !params['search']['location'].nil?
      @search.location = params['search']['location'].join(',').strip.gsub(/^,/, "")
      end
      if !@search.option.nil? && !params['search']['option'].nil?
      @search.option = params['search']['option'].join(',').strip.gsub(/^,/, "")
      end
    end
    params.require(:search).permit(:price, :email, :username, :user_id, :location, :floor, :lift, :surface, :room, :bedroom, :to_renovate, :comment, :text_for_agency, :option)
  end
end









