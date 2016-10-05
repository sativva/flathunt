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
    else
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
  end

  def update
    @announce = Announce.find(params['id'])
    # if !params['announce']['link'].nil?
    #   announce_scrap_seloger(params['announce']['link'])
    # else
      respond_to do |format|

        if @announce.update(announce_params)
          format.html { redirect_to search_announce_path(@announce.search_id, @announce), notice: 'Announce was successfully updated.' }
          format.json { render :show, status: :ok, location: @announce }
        else
          format.html { render :edit }
          format.json { render json: @announce.errors, status: :unprocessable_entity }
        end
      end
    # end
  end

  def destroy
    @announce.destroy
    respond_to do |format|
      format.html { redirect_to search_url(@search), notice: 'Announce was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def visited_mail
    @announce = Announce.find(params['announce_id'])
    AnnounceMailer.visited(@announce, @search).deliver_now
    redirect_to search_announce_path(@search, @announce)
  end

  private

    def announce_scrap_seloger(link)
      # seloger ---------------------
      if link.include?('seloger')
        # raise
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
        end

        respond_to do |format|

          if @announce.update({
            price: price,
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
            format.html { redirect_to search_announce_path(@announce.search_id, @announce), notice: 'Announce was successfully updated.' }
            format.json { render :show, status: :ok, location: @announce }

          else
            format.html { render :edit }
            format.json { render json: @announce.errors, status: :unprocessable_entity }
          end
        end

      # le bon coin ---------------
      elsif link.include?('leboncoin')

        html_file = open(link)
        html_doc = Nokogiri::HTML(html_file)

        price = html_doc.search('.item_price').first.attributes['content'].value
        html_doc.search('.property').each do |p|
         p.children.text == 'Surface'
          if p.children.text == 'Surface'
           surface = p.next_element.children.text.to_i
          end
        end
        scripts = html_doc.css('script').map(&:text)
        photos = []
        scripts.select{ |s| s['images_thumbs'] }.join.split(';').each do |l|
          if !l.match(/(..)(leboncoin.fr\/images\/)(.+)/).nil?
            link = l.match(/(..)(leboncoin.fr\/images\/)(.+)/)
            p link
            photos <<  "http://img" + link[0].gsub((/\"/), "")
          elsif !l.match(/(..)(leboncoin.fr\/xxl\/)(.+)/).nil?
            link = l.match(/(..)(leboncoin.fr\/xxl\/)(.+)/)
            p link
            photos <<  "http://img" + link[0].gsub((/\"/), "")
          end
        end

        comment = html_doc.search('.properties_description').text
        agency = html_doc.search('.ad_pro').text.strip

        # if !agent.page.forms[1].nil?
        #   price = agent.page.forms[1][name: "financement-prix"].to_i * 1000
        #   surface = agent.page.forms[0][name: 'surface'].gsub(',', '.').to_f
        #   agency = agent.page.forms[0][name: 'nomagence']
        #   comment = agent.page.forms[0][name: 'description']
        #   photos = []

        #   agent.page.parser.css('.carrousel-img').each do |b|
        #     photos << b.attributes['src'].value
        #   end
        #   photos.each do |photo|
        #     photo.gsub!('crop/175x175','height/400')
        #   end
        photos = photos.join(',')

        respond_to do |format|

          if @announce.update({
            price: price,
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
            format.html { redirect_to search_announce_path(@announce.search_id, @announce), notice: 'Announce was successfully updated.' }
            format.json { render :show, status: :ok, location: @announce }

          else
            format.html { render :edit }
            format.json { render json: @announce.errors, status: :unprocessable_entity }
          end
        end

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
        :status,
        :search_id,
        :scd_visit)
    end
end





