class APIPostsController < ApplicationController
  def index #Get
    render App.posts.to_json, status: "200 OK"
  end

  def show #Get
    post = find_post_by_id

    if post
     render post.to_json
    else
     render_not_found
    end
  end

  def create
    last_post = App.posts.max_by { |post| post.id }
    new_id = last_post.id + 1

    App.posts.push(
      Post.new(new_id, params["title"], params["author"],params["body"], true)
    )
    render({ message: "Successfully created!", id: new_id }.to_json)
  end

  def update
    post = find_post_by_id

    if post
      unless params["title"].nil? || params["title"].empty?
        post.title = params["title"]
      end

      unless params["author"].nil? || params["author"].empty?
        post.author = params["author"]
      end

      unless params["body"].nil? || params["body"].empty?
        post.body = params["body"]
      end

      render post.to_json, status: "200 OK"
    else
      render_not_found
    end
  end

  def destroy
    post = find_post_by_id

    if post
      render ({ message: "Successfully Deleted post"}).to_json
    else
      render_not_found
    end
  end


  private

  def find_post_by_id
    App.posts.find { |t| t.id == params[:id].to_i }
  end

  def render_not_found
    return_message = {
      message: "post not found",
      status: '404'
    }.to_json

    render return_message, status: "404 Not Found"
  end
end
