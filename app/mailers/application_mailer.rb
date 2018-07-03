class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets['guser']
  layout 'mailer'
end
