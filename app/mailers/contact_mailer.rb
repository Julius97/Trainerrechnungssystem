class ContactMailer < ActionMailer::Base
  	default from: "Trainerrechnungssystem-Software <infomail@trainerrechnungssystem.de>"

  	def send_contact_form(first_name, last_name,mail,subject,message)
  		@first_name = first_name
  		@last_name = last_name
        @mail_address = mail
        @subject = subject
        @message = message
        mail_subject = "Kontaktformular Trainerrechnungssystem - " + subject
  		mail(to: "julius.rueckin@gmail.com", subject: mail_subject)
  	end

end