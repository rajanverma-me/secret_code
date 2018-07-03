class SecretCodeMailer < ApplicationMailer

	def email_code(email, code)
		@email = email
		@code = code
    mail(to: email, subject: 'Secret Code')
  end
end
