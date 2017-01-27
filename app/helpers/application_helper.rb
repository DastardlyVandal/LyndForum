module ApplicationHelper
    def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true,
      no_styles: true,
      no_images: true,
      safe_links_only: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  def validate_mod
      if current_user.role == 0 or current_user.role == 1
          return true
      end
      return false
  end

  def validate_admin
      if current_user.role == 0
          return true
      end
      return false
  end
end
