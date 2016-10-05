class AnnounceMailer < ApplicationMailer
  default from: 't0649840679@gmail.com'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.announce_mailer.visited.subject
  #
  def visited(announce, search)

    @announce = announce
    @search = search
    @user = @search.username


    mail(to: @search.email, bcc: "t.rondio@free.fr", subject: "J'ai effectué une visite pour vous")
  end
end
