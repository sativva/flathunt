class AgencyMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.agency_mailer.newsearch.subject
  #
  def newsearch(agency, search)
    @greeting = "Hi"
    @agency = agency
    @search = search

    mail(from: @search.email, to: @agency.mail, subject: 'Nouvelle recherche')
  end
end
