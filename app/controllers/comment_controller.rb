require 'erb'
class CommentController < ApplicationController
  def index #Get
    if request[:format] == "json"
      render App.comments.to_json, status: "200 OK"
    else
      @comments = App.comments
      render_template 'index.html.erb'
    end
  end

  def show #Get
    comment = find_comment_by_id

    if comment
      if request[:format] == "json"
        render comment.to_json
      else
        @comment = comment
        render_template 'show.html.erb'
      end
    end
  end

# new
  def new
    render_template 'comments/new.html.erb'
  end

  def create #post
    last_comment = App.comments.max_by { |comment| comment.id}
    new_id = last_comment.id + 1

    App.comments.push(
      comment.new(new_id, params["message"], params["author"], params["post_id"] false)
    )
    puts App.comments.to_json

    render({ message: "Successfully created!", id: new_id }.to_json)
  end

  # edit
  def update #PUT
    comment = find_comment_by_id

    if comment
      unless params["message"].nil? || params["message"].empty?
        comment.message = params["message"]
      end

      unless params["author"].nil? || params["author"].empty?
        comment.author = params["author"]
      end

      unless params["post_id"].nil? || params["post_id"].empty?
        comment.post_id = params["post_id"]
      end

      render comment.to_json, status: "200 OK"
    else
      render_not_found
    end
  end

  def destroy #DELETE
    comment = find_comment_by_id

    if comment
      App.comments.delete(comment) #destory it
        render ({ message: "Successfully Deleted comment"}).to_json
      else
        render_not_found
    end
  end

    private

    def find_comment_by_id
      App.comments.find { |t| t.id == params[:id].to_i }
    end

    def render_not_found
      return_message = {
        message: "comment not found",
        status: '404'
      }.to_json

      render return_message, status: "404 Not Found"
    end
end
