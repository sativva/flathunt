require 'open-uri'
require 'nokogiri'

class Search < ApplicationRecord
  # after_create :get_announces
  has_many :announces, dependent: :destroy
  accepts_nested_attributes_for :announces
  # validates :username, presence: true#, length: { maximum: 100 }
  # validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  # validates :location, presence: true
  validates :surface, presence: true
  validates :price, presence: true
  include SearchesHelper

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

    @announce.update({
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


  def get_announces

    @search = Search.last
    # @search.location = JSON.parse(@search.location)
    # se_loger
    arrondissements = @search.location.gsub(/\ /,"").gsub('750', '7501')
    sllink = ["http://www.seloger.com/list.htm?org=advanced_search&pxmax=#{@search.price}&surfacemin=#{@search.surface}&idtt=2&idtypebien=1,2,9&ci=#{arrondissements}&tri=d_dt_crea&idpublication=&LISTING-LISTpg=1"]

    slalinks = []
    user_agent = 'Googlebot-Mobile'
    proxy = "http://111.7.162.48:8080"
    html_file = open(sllink.first,'User-Agent' => user_agent)
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.page_number a').each do |e|
      sllink << e.attribute('href').value
    end

    sllink.each do |sl|
      unless sl.nil?
        html_file = open(sl,'User-Agent' => user_agent)
        html_doc = Nokogiri::HTML(html_file)

        html_doc.search('.listing_link').each do |e|
          slalinks << e.attribute('href').value
        end
      end
    end
    slalinks.each do |link|
      @announce = Announce.new
      announce_scrap(link)
    end
  end
end

