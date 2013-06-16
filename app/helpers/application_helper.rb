module ApplicationHelper

	def markdown(text)
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true,
			:spacer_after_headers => true, :no_intra_emphasis => true)

		markdown.render(text).html_safe
	end
end
