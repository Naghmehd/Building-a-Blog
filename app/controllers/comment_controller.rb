require 'erb'
class CommentsController < ApplicationController
  def index #Get
      @comments = App.comments
      render_template 'comments/index.html.erb'
  end

  def show #Get
    comment = find_comment_by_id

    if comment
        @comment = comment
        render_template 'comments/show.html.erb'
      else
        render_not_found
    end
  end

  def new
    render_template 'comments/new.html.erb'
  end

  def create #post
    last_comment = App.comments.max_by { |comment| comment.comment_id}
    new_id = last_comment.comment_id + 1

    App.comments.push(
      Comment.new(new_id, params[:message], params[:author], params[:post_id])
    )

    redirect_to '/comments'
  end

  def destroy #DELETE
    comment = find_comment_by_id

    if comment
      App.comments.delete(comment) #destory it
      else
        render_not_found
    end
  end

    private

    def find_comment_by_id
      App.comments.find { |c| c.comment_id == params[:id].to_i }
    end

    def render_not_found
      render_template "comments/not_found.html.erb"
    end
end
