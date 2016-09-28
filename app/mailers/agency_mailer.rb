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
    delivery_options = { user_name: 't0649840679',
                         password: 'street75',
                         address: 'smtp.gmail.com' }

    mail(to: @agency.mail, subject: 'Nouvelle recherche')
  end
end
