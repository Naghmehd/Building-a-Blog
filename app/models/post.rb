class Post
attr_accessor :id, :title, :author, :body, :publish

  def initialize(id, title, author, body, publish)
    @id = id
    @title = title
    @author = author
    @body = body
    @publish = publish
  end

  def to_json(_ = nil)
    {
      id: id,
      title: title,
      author: author,
      body: body,
      publish: publish
    }.to_json
  end

  def published?
    @published == false
  end
end
