module PostsHelper
  def post_author(post)
    post.user.login
  end

  def comment_author(comment)
    comment.user.login
  end

  def safe_textilize(str)
    return unless str && str.respond_to?(:to_s)
    doc = RedCloth.new(str.to_s)
    doc.filter_html = true
    render_haml(doc.to_html)
  end

  def post_image(post)
    post.image.present? ? post.image.thumb.url : post.image.default_url
  end

  def post_image_for_show_page
    @post.image.blank? ? 'No Image Available' : render_haml(image_tag @post.image)
  end

  private

  def render_haml(code)
    engine = Haml::Engine.new(code)
    engine.render
  end
end
