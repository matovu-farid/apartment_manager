# frozen_string_literal: true

ActionMailer::Base.smtp_settings = {
  user_name: 'apikey',
  password: ENV.fetch('SENDGRID_API_KEY', nil),
  # domain: "your-domain.com",
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
