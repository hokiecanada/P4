class Emailer < ActionMailer::Base
  default 	:from => "no-reply@vrknowledgebase.org"#,
			#:return_path => "hokiecanada@gmail.com"
  
  def entry_received(recipient, entry)     
	@recipient = recipient
	@entry = entry
	@url = "http://severe-leaf-80.heroku.com/users/sign_in"
	mail(:to => recipient,
		 :subject => "Entry Received by VR Knowledgebase") do |format|
		format.html
	end
  end
  
  def entry_approved(recipient, entry)     
	@recipient = recipient
	@entry = entry
	@url = "http://severe-leaf-80.heroku.com/users/sign_in"
	mail(:to => recipient,
		 :subject => "Entry Approved by VR Knowledgebase") do |format|
		format.html
	end
  end
  
  def entry_rejected(recipient, entry)     
	@recipient = recipient
	@entry = entry
	@url = "http://severe-leaf-80.heroku.com/users/sign_in"
	mail(:to => recipient,
		 :subject => "Entry Rejected by VR Knowledgebase") do |format|
		format.html
	end
  end
  
  def entry_updated(recipient, entry)     
	@recipient = recipient
	@entry = entry
	@url = "http://severe-leaf-80.heroku.com/users/sign_in"
	mail(:to => recipient,
		 :subject => "Entry Updated in VR Knowledgebase") do |format|
		format.html
	end
  end
  
  def entry_updated_by_admin(recipient, entry)     
	@recipient = recipient
	@entry = entry
	@url = "http://severe-leaf-80.heroku.com/users/sign_in"
	mail(:to => recipient,
		 :subject => "Entry Updated in VR Knowledgebase") do |format|
		format.html
	end
  end
  
  def comment_added(recipient, entry, comment)     
	@recipient = recipient
	@entry = entry
	@comment = comment
	@url = "http://severe-leaf-80.heroku.com/users/sign_in"
	mail(:to => recipient,
		 :subject => "Someone has commented on your entry in the VR Knowledgebase") do |format|
		format.html
	end
  end
  
  def admin_entry_added(recipient, entry)     
	@recipient = recipient
	@entry = entry
	@url = "http://severe-leaf-80.heroku.com/admins/sign_in"
	mail(:to => recipient,
		 :subject => "Entry Added to VR Knowledgebase") do |format|
		format.html
	end
  end

  def admin_entry_updated(recipient, entry)     
	@recipient = recipient
	@entry = entry
	@url = "http://severe-leaf-80.heroku.com/admins/sign_in"
	mail(:to => recipient,
		 :subject => "Entry Updated in VR Knowledgebase") do |format|
		format.html
	end
  end
  
  def admin_comment_added(recipient, entry, comment)     
	@recipient = recipient
	@entry = entry
	@comment = comment
	@url = "http://severe-leaf-80.heroku.com/admins/sign_in"
	mail(:to => recipient,
		 :subject => "Comment Added to VR Knowledgebase") do |format|
		format.html
	end
  end
end
