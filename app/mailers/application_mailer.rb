class ApplicationMailer < ActionMailer::Base
		
	default  from: 'noreply@photon-factory.herokuapp.com'
	#default  from: #'from@example.com'
	layout 'mailer'
end
