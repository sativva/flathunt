ActionMailer::Base.smtp_settings = {
  address: ENV['7022e888-702e-4310-9300-44531b99ba82'],
  port: '25',
  domain: 'mylovelyplace.heroku.com',
  user_name: ENV['POSTMARK_API_KEY'],
  password: ENV['POSTMARK_API_TOKEN'],
  authentication: :cram_md5,
  enable_starttls_auto: true
}
