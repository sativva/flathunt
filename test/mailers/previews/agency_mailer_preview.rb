class AgencyMailerPreview < ActionMailer::Preview
  def newsearch
    @agency = Agency.last
    @search = Search.last
    AgencyMailer.newsearch(@agency, @search)
  end
end
