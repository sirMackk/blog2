atom_feed :language => 'en-US' do |feed|
	feed.title @title
	feed.updated @updated

	@posts.each do |post|
		next if post.updated_at.blank?

		feed.entry(post) do |entry|
			entry.url show_post_url(post.slug)
			entry.title post.title
			entry.content post.description, :type => 'html'


			entry.updated(post.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))

			entry.author = 'Matt'
		end
	end
end
