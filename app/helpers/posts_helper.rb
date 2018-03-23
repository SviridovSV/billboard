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

  def array_of_words(text)
    text.split(' ')
  end

  def textile_word(word)
    return render_haml(textilize(word)) if textile_text(@post.text).include?(word)
    word
  end

  private

  def textile_text(text)
    t = text.split(' ') - RedCloth.new(text).to_html.split(' ')
    t.empty? ? false : t
  end
end
