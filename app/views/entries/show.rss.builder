xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
	xml.channel do
		xml.title 		@entry.title
		xml.description @entry.summary
		xml.link entry_url(@entry, :html)
		
		for comment in @entry.comments
			xml.item do
				xml.title			comment.comment
				xml.pubDate	 		comment.created_at
				xml.description		User.find(comment.user_id).email
				xml.link			entry_url(Entry.find(comment.entry_id), :html)
			end
		end
	end
end