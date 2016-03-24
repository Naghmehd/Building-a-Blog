class Comment
attr_accessor :id, :message, :author, :post_id

  def initialize(id, title, author, post_id)
    @id = id
    @title = title
    @author = author
    @post_id = post_id
  end

  def to_json(_ = nil)
    {
      id: id,
      title: title,
      author: author,
      post_id: post_id
    }.to_json
  end

  def link_id
    @post_id = @id
  end
end