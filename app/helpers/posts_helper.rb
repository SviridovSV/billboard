module PostsHelper
  def post_author(post)
    post.user.login
  end
end
