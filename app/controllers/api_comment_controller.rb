class APICommentsController < ApplicationController
  def index #Get
    render App.comments.to_json, status: "200 OK"
  end

  def show #Get
    post = find_comment_by_id

    if comment
     render comment.to_json
    else
     render_not_found
    end
  end

  def create
    last_comment = App.comments.max_by { |comment| comment.comment_id }
    new_id = last_comment.comment_id + 1

    App.Comments.push(
      Comment.new(new_id, params["message"], params["author"],params["post_id"], true)
    )
    render({ message: "Successfully created!", id: new_id }.to_json)
  end

  def destroy
    comment = find_comment_by_id

    if post
      render ({ message: "Successfully Deleted post"}).to_json
    else
      render_not_found
    end
  end


  private

  def find_comment_by_id
    App.comments.find { |c| c.id == params[:id].to_i }
  end

  def render_not_found
    return_message = {
      message: "post not found",
      status: '404'
    }.to_json

    render return_message, status: "404 Not Found"
  end
end
