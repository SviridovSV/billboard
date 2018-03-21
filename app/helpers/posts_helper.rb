module PostsHelper
  def post_author(post)
    post.user.login
  end

  def comment_author(comment)
    comment.user.login
  end
end
