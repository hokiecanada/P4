class Emailer < ActionMailer::Base
  default 	:from => "no-reply@vrknowledgebase.org",
			:return_path => "hokiecanada@gmail.com"
  
  def entry_approved(recipient)     
	@account = recipient
	@subject = "Entry has been approved"
	mail(:to => recipient)
  end
end
