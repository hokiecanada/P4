xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
	xml.channel do
		xml.title "VR Knowledgebase"
		xml.description "Repository of immersion knowledge"
		
		for entry in @entries
			xml.item do
				xml.title 			entry.title
				xml.description 	entry.summary
				xml.pubDate	 		entry.updated_at
				xml.link 			entry_url(entry, :html)
			end
		end
	end
end