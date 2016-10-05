class AnnounceMailerPreview < ActionMailer::Preview
  def visited
    @announce = Announce.first
    @search = Search.first
    AnnounceMailer.visited
  end
end
