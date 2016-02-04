module TopicsHelper

  def topics_filter(options)
    params.slice(:order, :category, :tag).merge(options)
  end

end
