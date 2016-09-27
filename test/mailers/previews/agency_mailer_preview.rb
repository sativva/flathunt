class AgencyMailerPreview < ActionMailer::Preview
  def newsearch(agency)
    AgencyMailer.newsearch(agency)
  end
end
