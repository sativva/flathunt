require 'open-uri'
require 'nokogiri'
require 'mechanize'

class AnnouncesController < ApplicationController
  before_action :set_announce, only: [:show, :edit, :update, :destroy]
  before_action :set_search
  skip_before_action :authenticate_user!, only: [ :index ]
  # before_action :set_user

  def index
    @announces = @search.announces
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
       announce_scrap(params['announce']['link'])
    else
      respond_to do |format|
        @announce.class != Announce ? @announce = @announce.first : @announce
        if @announce.save
          format.html { redirect_to user_search_announce_path(@search, @announce), notice: 'Announce was successfully created.' }
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

    respond_to do |format|

      if @announce.update(announce_params)
        format.html { redirect_to user_search_announce_path(@user, @search, @announce), notice: 'Announce was successfully updated.' }
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
      format.html { redirect_to user_search_url(@user, @search), notice: 'Announce was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def visited_mail
    @announce = Announce.find(params['announce_id'])
    raise

    if AnnounceMailer.visited(@announce, @search).deliver_now
    redirect_to user_search_announce_path(@user, @search, @announce), notice: 'Votre mail est correctement parti.'
    else
    redirect_to user_search_announce_path(@user, @search, @announce), notice: "Votre mail n'est pas correctement parti."
  end

  end

  private

  def announce_scrap(link)
    if link.include?('leboncoin')
      user_agent = Announce.random_desktop_user_agent
      proxy = "http://111.7.162.48:8080"
      html_file = open(link,'User-Agent' => user_agent)
      html_doc = Nokogiri::HTML(html_file)
      leboncoin(html_doc)
    else
      user_agent = 'Googlebot-Mobile'
      proxy = "http://111.7.162.48:8080"
      html_file = open(link,'User-Agent' => user_agent)
      html_doc = Nokogiri::HTML(html_file)
      if link.include?('seloger')
        seloger(html_doc)
      elsif link.include?('pap.fr')
        pap(html_doc)
      elsif link.include?('logic-immo.com')
        logicimmo(html_doc)
      end
    end
  end

  def logicimmo(doc)
    html_doc = doc
    price = html_doc.search('.price').text.scan(/\d/).join
    surface = html_doc.search('.offer-area-number').first.text
    address = html_doc.search(".offer-locality").children.children.children.text.strip

    photos = []
    html_doc.search(".carousel-content").first.children.children.children.children.each do |pic|
      if pic.attributes['src']
        photos << pic.attributes['src'].value.gsub('75x75', '800x600')
      end
    end
    photos = photos.join(',')
    agency = html_doc.search('.agency-name').text.strip
    room = html_doc.search('.offer-rooms-number').first.text.to_i
    comment = html_doc.search('.offer-description-text').text.strip
    lift = false
    floor = ""
    html_doc.search('.criteria-label').each do |criteria|
      if criteria.children.text.include?('Ascenseur')
        lift = true
      elsif criteria.children.text.include?('Etage du bien')
        floor = criteria.next_element.text.to_i
      end
    end

    respond_to do |format|

      if @announce.update({
        price: price, surface: surface, address: address, photos: photos,
        agency: agency, room: room, comment: comment, lift: lift, floor: floor
        })
        format.html { redirect_to user_search_announce_path(@user, @announce.search_id, @announce), notice: 'Announce was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def pap(doc)
    html_doc = doc
    address = html_doc.search(".item-geoloc").children.children.first.text
    photos = []
    html_doc.search(".showcase-thumbnail").children.each do |pic|
      if pic.attributes['src']
        photos << pic.attributes['src'].value
      end
    end
    photos = photos.join(',')
    comment = html_doc.search('.item-description').text
    price = html_doc.search('.price').children.text.gsub(".","").to_i
    agency = html_doc.search('.tel-wrapper').children.first.text.gsub('.','') if !html_doc.search('.tel-wrapper').children.first.nil?
    surface = ""
    room = ""
    bedroom = ""


    html_doc.search('.item-summary>li').each do |p|
      if p.children.text.include?('Surface')
        surface = p.children.text.strip.scan(/\d/).join
      elsif p.children.text.include?('Pièces')
        room = p.children.text.strip.scan(/\d/).join
      elsif p.children.text.include?('Chambre')
        bedroom = p.children.text.strip.scan(/\d/).join
      end
    end

    respond_to do |format|

      if @announce.update({
        price: price, surface: surface, address: address, photos: photos,
        agency: agency, room: room, bedroom: bedroom, comment: comment
        })
        format.html { redirect_to user_search_announce_path(@user, @announce.search_id, @announce), notice: 'Announce was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def seloger(doc)
    # seloger ---------------------
    html_doc = doc
    price = html_doc.search('#price').first.text.to_i*1000
    comment = html_doc.search('.description').text.encode("iso-8859-1").force_encoding("utf-8")
    address = html_doc.search('.detail-title_subtitle').text.strip.gsub('- ', '')
    agency = html_doc.search('.agence-title').text.strip.scan(/^(.+)\r\n/).first.join
    surface = ""
    lift = false
    floor = ""
    room = ""
    bedroom = ""
    guard = false
    photos = []
    agency_phone = html_doc.search('.agency_phone').first.attributes['data-phone'].value
    html_doc.search('.carrousel-img').each do |p|
      mpic = p.attributes['src'].value
      hpic = mpic.gsub('crop/175x175','height/800')
      photos << hpic
    end
    html_doc.search('.description-liste').first.children.each do |e|
      if e.text.include?('Surface de')
        surface = e.children.text.scan(/\d/).join
      elsif e.text.include?('Ascenseur')
        lift = true
      elsif e.text.include?('Gardien')
        gard = true
      elsif e.text.include?('Etage')
        if !e.text.include?('Etages')
          floor = e.children.text.to_i
        end
      elsif e.text.include?('PiÃ¨ce')
        room = e.children.text.to_i
      elsif e.text.include?('Chambre')
        bedroom = e.children.text.to_i
      end
    end
    photos = photos.join(',')
    agency = agency + " - " + agency_phone

    respond_to do |format|
      if @announce.update({
        price: price,
        surface: surface,
        address: address,
        photos: photos,
        floor: floor,
        # charge_by_month: charge_by_month
        # lot: lot
        agency: agency,
        # date_of_publication: date_of_publication
        lift: lift,
        room: room,
        bedroom: bedroom,
        # to_renovate: to_renovate
        comment: comment,
        guard: guard
        # option: option
        })

        format.html { redirect_to user_search_announce_path(@user, @search, @announce), notice: 'Announce was successfully updated.' }
        format.json { render :show, status: :ok, location: @announce }
      else
        format.html { render :edit }
        format.json { render json: @announce.errors, status: :unprocessable_entity }
      end
    end
  end

  def leboncoin(doc)

    html_doc = doc
    address = html_doc.search(".clearfix>.value").children[1].text.strip
    # agency = html_doc.search('.ad_pro').text.strip
    scripts = html_doc.css('script').map(&:text)
    photos = []
    scripts.select{ |s| s['images_thumbs'] }.join.split(';').each do |l|
      if !l.match(/(..)(leboncoin.fr\/ad-large\/)(.+)/).nil?
        photolink = l.match(/(..)(leboncoin.fr\/ad-large\/)(.+)/)
        photos <<  "http://img" + photolink[0].gsub((/\"/), "")
      elsif !l.match(/(..)(leboncoin.fr\/xxl\/)(.+)/).nil?
        photolink = l.match(/(..)(leboncoin.fr\/xxl\/)(.+)/)
        photos <<  "http://img" + photolink[0].gsub((/\"/), "")
      elsif l.match(/leboncoin.fr\/images/)
        photos << "http://" + l.scan(/\/\/(.+).jpg/).join + ".jpg"
      end
    end
    photos = photos.join(',')
    surface = ""
    room = ""
    comment = html_doc.search('.properties_description').text
    price = html_doc.search('.item_price').first.attributes['content'].value
    html_doc.search('.property').each do |p|
      if p.children.text == 'Surface'
        surface = p.next_element.children.text.to_i
      elsif p.children.text == 'Pièces'
        room = p.next_element.children.text
      end
    end

    respond_to do |format|

      if @announce.update({
        price: price,
        surface: surface,
        address: address,
        photos: photos,
        # floor: floor,
        # charge_by_month: charge_by_month
        # lot: lot
        # agency: agency,
        # date_of_publication: date_of_publication
        # lift: lift,
        room: room,
        # bedroom: bedroom,
        # to_renovate: to_renovate
        comment: comment
        # guard: guard
        # option: option
        })
        format.html { redirect_to user_search_announce_path(@user, @announce.search_id, @announce), notice: 'Announce was successfully updated.' }
        format.json { render :show, status: :ok, location: @announce }

      else
        format.html { render :edit }
        format.json { render json: @announce.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_announce
    @announce = Announce.find(params['id'])
  end

  def set_search
    @search = Search.find(params['search_id'])
  end

  def set_user
    @user = User.find(params['user_id'])
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





