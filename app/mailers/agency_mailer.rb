class AgencyMailer < ApplicationMailer
default from: "t0649840679@gmail.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.agency_mailer.newsearch.subject
  #
  def newsearch(agency, search)
    @greeting = "Hi"
    @agency = agency
    @search = search


    mail(to: @agency.mail, subject: 'Nouvelle recherche')
  end
end
