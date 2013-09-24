module ApplicationHelper

  @@main_url = "http://mattscodecave.com"

  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true,
      :spacer_after_headers => true, :no_intra_emphasis => true)

    markdown.render(text).html_safe
  end

  def multi_file_upload(model, csrf_token)
  	#creates an upload form for uploading multiple files
  	# for use with file_uploads.js
  	upload_html = <<-END_OF_STRING
  	<div class="field">
			<form id="file_upload"
			action="/posts/#{model.id}/uploads" 
			value="#{@@main_url}"
			enctype="multipart/form-data"
			method="POST">
				<input name="authenticity_token"
				   type="hidden"
				   value="#{csrf_token}">
				<input
					type="file"
					multiple="multiple"
					name="upload[]">
				<input type="submit" value="Upload">
			</form>
		</div>
		<div class="field" id="uploaded_images">
			<table>
				<thead>
					<th>Image</th>
					<th>Markdown code</th>
					<th>Delete?</th>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
		END_OF_STRING

		upload_html.html_safe
  end

end
