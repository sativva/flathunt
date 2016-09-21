# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Agency.destroy_all

def populate_agencies_db
  require 'open-uri'
  require 'nokogiri'
  (1..20).each do |num|
  # num = 2
    html_file = open("http://www.immostreet.com/Agency/Search?place=&place_id=4832012&currentPage=#{num}")
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.agence').each do |element|
      puts name = element.search('h3').xpath('text()')
      puts mail = element.search('address a').xpath('text()').to_s.reverse
      puts address = element.search('address').xpath('text()').to_s.gsub(/(Tél)(.*)/, "").gsub(/(Fax)(.*)/, "").strip
      puts postal = element.search('address').to_s.match(/^(\d{5})/).to_s.to_i
      puts phone = element.search('address').xpath('text()').to_s.match(/\d{10}/)
      puts logo = element.search('.logo img').to_s.match(/(".*")/).to_s.gsub('"','').gsub(/(alt=.*)/, "")
      puts url = element.search('.logo a').xpath('text()')

      @agency = Agency.new({
        name: name,
        mail: mail,
        address: address,
        postal: postal,
        phone: phone,
        url: url,
        logo: logo
        })
      @agency.save
    end
  end
end

populate_agencies_db



