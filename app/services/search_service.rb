class SearchService
  def initialize(search_phrase, search_param)
    @search_phrase = search_phrase
    @search_param = search_param
  end

  def filter_by_search_param
    case @search_param
    when 'by_tag'
      posts = Post.tagged_with(@search_phrase)
    when 'by_author'
      posts = Post.filter_by_author(@search_phrase)
    when 'by_content'
      posts = Post.filter_by_content(@search_phrase)
    when 'by_address'
      posts = Post.filter_by_address(@search_phrase)
    end
  end
end
