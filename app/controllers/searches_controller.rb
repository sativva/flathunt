class SearchesController < ApplicationController
  before_action :set_user
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
    @price_max = boncoin(@search.price)
    @surface_bc = boncoin_surface(@search.surface)
    @announces = Announce.where(search_id: @search).reverse
  end

  def new
    if session[:form_data]
      Search.create(session[:form_data]['search'])
      redirect_to root_path, notice: 'La recherche a correctement été crée. Nous revenons vers vous très rapidement. '
    else
      @search = Search.new
      @user = User.find(1)
    end
  end

  def edit
  end

  def create
    if current_user.nil?
       # Store the form data in the session so we can retrieve it after login
       session[:form_data] = params
       # Redirect the user to register/login
       redirect_to new_user_registration_path

    else

      @search = Search.new(search_params)
      @search.user_id = current_user.id
      @search.floor = params['search']['floor'].join(',').strip.gsub(/^,/, "")
      @search.location = params['search']['location'].join(',').strip.gsub(/^,/, "")
      @search.option = params['search']['option'].join(',').strip.gsub(/^,/, "")

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

  def boncoin(price)
    price_max = price.to_i.round(-5).to_s
    price_bc = %w(0 25000 50000 75000 100000 125000 150000 175000 200000 225000 250000 275000 300000 325000 350000 400000 450000 500000 550000 600000 650000 700000 800000 900000 1000000 1100000 1200000 1300000 1400000 1500000 2000000)
    if price_bc.include?(price_max)
      price_max = price_bc.index(price_max)
    end
  end

  def boncoin_surface(surface)
    surface_max = surface.to_i.round(-1).to_s
    surface_bc = %w(0 20 25 30 35 40 50 60 70 80 90 100 110 120 130 140 150 200 300)
    if surface_bc.include?(surface_max)
      surface_max = surface_bc.index(surface_max)
    end
  end

  def set_search
    @search = Search.find(params[:id])
  end
  def set_user
    @user = User.find(current_user)
  end

  def search_params
    params.require(:search).permit(:price, :email, :username, :user_id, :location, :floor, :lift, :surface, :room, :bedroom, :to_renovate, :comment, :option)
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









