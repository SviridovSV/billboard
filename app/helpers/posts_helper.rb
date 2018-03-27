module PostsHelper
  def post_author(post)
    post.user.login
  end

  def comment_author(comment)
    comment.user.login
  end

  def render_haml(code)
    engine = Haml::Engine.new(code)
    engine.render
  end

  def safe_textilize(str)
    if str && str.respond_to?(:to_s)
      doc = RedCloth.new(str.to_s)
      doc.filter_html = true
      doc.to_html
    end
  end

  def post_image(post)
    post.image.present? ? post.image.thumb.url : post.image.default_url
  end
end
