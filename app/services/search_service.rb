class SearchService
  def initialize(search_phrase, search_param)
    @search_phrase = search_phrase
    @search_param = search_param
  end

  def filter_by_search_param
    return Post.tagged_with(@search_phrase) if by_tag?
    return Post.filter_by_author(@search_phrase) if by_author?
    return Post.filter_by_content(@search_phrase) if by_content?
    return Post.filter_by_address(@search_phrase) if by_address?
  end

  private

  def by_tag?
    @search_param == 'by_tag'
  end

  def by_author?
    @search_param == 'by_author'
  end

  def by_content?
    @search_param == 'by_content'
  end

  def by_address?
    @search_param == 'by_address'
  end
end
