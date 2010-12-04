class Emailer < ActionMailer::Base
  default 	:from => "no-reply@vrknowledgebase.org"#,
			#:return_path => "hokiecanada@gmail.com"
  
  def entry_approved(recipient, title, date)     
	@recipient = recipient
	@title = title
	@date = date
	@subject = "Entry has been approved"
	mail(:to => recipient) do |format|
		format.html
	end
  end
end
