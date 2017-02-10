class ApplicationMailer < ActionMailer::Base
  default  :from     => 'from@example.com',
          :reply_to => 'rmac460@aucklanduni.ac.nz'
  layout 'mailer'
end
