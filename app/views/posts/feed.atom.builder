atom_feed do |feed|
	feed.title @title
	feed.updated @updated

	@posts.each do |post|
		next if post.updated_at.blank?
		feed.entry(post, url: show_post_url(post.slug)) do |entry|
			entry.title(post.title)
			entry.content(post.description, :type => 'html')
			entry.updated(post.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))
			entry.author('Matt')
		end
	end
end
