require 'open-uri'
require 'nokogiri'
require 'mechanize'

class AnnouncesController < ApplicationController
  before_action :set_announce, only: [:show, :edit, :update, :destroy]
  before_action :set_search

  def index
    @announces = Announce.all
  end

  def show
  end

  def new
    @announce = Announce.new
  end

  def edit
  end

  def create
    @announce = Announce.new(announce_params)
    if !params['announce']['link'].nil?
       announce_scrap_seloger(params['announce']['link'])
    end
    respond_to do |format|
      @announce.class != Announce ? @announce = @announce.first : @announce
      if @announce.save
        format.html { redirect_to search_announce_path(@announce.search_id, @announce), notice: 'Announce was successfully created.' }
        format.json { render :show, status: :created, location: @announce }
      else
        format.html { render :new }
        format.json { render json: @announce.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @announce = Announce.find(params['id'])
    if !params['announce']['link'].nil?
      announce_scrap_seloger(params['announce']['link'])
    end
    respond_to do |format|
      if @announce.update(announce_params)
        format.html { redirect_to search_announce_path(@announce.search_id, @announce), notice: 'Announce was successfully updated.' }
        format.json { render :show, status: :ok, location: @announce }
      else
        format.html { render :edit }
        format.json { render json: @announce.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @announce.destroy
    respond_to do |format|
      format.html { redirect_to search_url(@search), notice: 'Announce was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def announce_scrap_seloger(link)
      agent = Mechanize.new
      agent.get(link)
      if !agent.page.forms[1].nil?
        price = agent.page.forms[1][name: "financement-prix"].to_i * 1000
        surface = agent.page.forms[0][name: 'surface'].gsub(',', '.').to_f
        agency = agent.page.forms[0][name: 'nomagence']
        comment = agent.page.forms[0][name: 'description']
        photos = []

        agent.page.parser.css('.carrousel-img').each do |b|
          photos << b.attributes['src'].value
        end
        photos.each do |photo|
          photo.gsub!('crop/175x175','height/400')
        end
        photos = photos.join(',')

        @announce.update({
          price: price * 1000,
          surface: surface,
          # address: address,
          photos: photos,
          # floor: floor,
          # charge_by_month: charge_by_month
          # lot: lot
          agency: agency,
          # date_of_publication: date_of_publication
          # lift: lift,
          # room: room
          # bedroom: bedroom
          # to_renovate: to_renovate
          comment: comment
          # guard: guard
          # option: option
          })
      end
    end


    def set_announce
      @announce = Announce.find(params['id'])
    end
    def set_search
      @search = Search.find(params['search_id'])
    end

    def announce_params
      params.require(:announce).permit(
        :link,
        :price,
        :address,
        :floor,
        :charge_by_month,
        :lot,
        :photos,
        :agency,
        :date_of_publication,
        :lift,
        :surface,
        :room,
        :bedroom,
        :to_renovate,
        :comment,
        :guard,
        :option,
        :search_id)
    end
end
