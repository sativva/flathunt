module SearchesHelper

  def set_partner_links(search)
    @price_max = boncoin(@search.price)
    @surface_bc = boncoin_surface(@search.surface)
    partner_links = []
    # @search.location = JSON.parse(@search.location)
    # se_loger
    arrondissements = @search.location.gsub(/\ /,"").gsub('750', '7501')
    partner_links << "http://www.seloger.com/list.htm?org=advanced_search&pxmax=#{@search.price}&surfacemin=#{@search.surface}&idtt=2&idtypebien=1,2,9&ci=#{arrondissements}"
    # le bon coin
    if @search.location.split(',').length > 3
      @search.location.split(',').each_slice(3) do |slice|
        arrondissement_bc = slice.join(',').gsub(/\ /,"").gsub('750', 'Paris%20750').split(',').join('%2C')
        if !@price_max.nil?
          partner_links << "https://www.leboncoin.fr/ventes_immobilieres/offres/ile_de_france/?th=1&location=#{arrondissement_bc}&parrot=0&ps=#{@price_max - 4}&pe=#{@price_max}&sqs=#{@surface_bc}"
        end
      end
    else
      arrondissement_bc = @search.location.gsub(/\ /,"").gsub('750', 'Paris%20750').split(',').join('%2C')
      if !@price_max.nil?
        partner_links << "https://www.leboncoin.fr/ventes_immobilieres/offres/ile_de_france/?th=1&location=#{arrondissement_bc}&parrot=0&ps=#{@price_max - 4}&pe=#{@price_max}&sqs=#{@surface_bc}"
      end
    end
    # pap.fr
    par_arrondissement = []
    @search.location.split(',').each do |arr|
      postal = arr.to_i - 75000 + 37767
      par_arrondissement << "g" + postal.to_s
    end
    room = @search.room ? "-#{@search.room}-pieces" : ""
    bedroom = @search.bedroom ? "-#{@search.bedroom}-chambres" : ""
    partner_links << "http://www.pap.fr/annonce/vente-appartements-" + par_arrondissement.join + room + bedroom +"-jusqu-a-#{@search.price}-euros-a-partir-de-#{@search.surface}-m2"
    #logicimmo

    if @search.location.split(',').length > 3
      @search.location.split(',').each_slice(3) do |slice|
        li_arr = []
        slice.each do |postal|
          if postal == "75001"
            postal = "23599_2"
          elsif postal == "75009"
            postal = "23609_2"
          elsif postal.include?("7501")
            postal = (postal.to_i - 75010 + 23589).to_s + "_2"
          elsif postal == "75020"
            postal = "23600_2"
          else
            postal = (postal.to_i - 75000 + 23599).to_s + "_2"
          end
          li_arr << postal
        end
        partner_links << "http://www.logic-immo.com/vente-immobilier-paris,#{li_arr.join(',')}/options/groupprptypesids=1,2,6,7,12,15/pricemax=#{@search.price}/areamin=#{@search.surface}"
      end
    else
      li_arr = []
      @search.location.split(',').each do |postal|
        if postal == "75001"
          postal = "23599_2"
        elsif postal == "75020"
          postal = "23600_2"
        else
          postal = (postal.to_i - 75000 + 23599).to_s + "_2"
        end
        li_arr << postal
      end
    partner_links << "http://www.logic-immo.com/vente-immobilier-paris,#{li_arr.join(',')}/options/groupprptypesids=1,2,6,7,12,15/pricemax=#{@search.price}/areamin=#{@search.surface}"
    end
    return partner_links
  end

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
end
