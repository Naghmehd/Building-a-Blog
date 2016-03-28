# Request / Response MVC!

* Fork this repo
* Clone this repo
* Create your controllers in `app/controllers`
  * Make sure they all inherit from `ApplicationController`
* Create your routes in `config/router.rb`
* Test out all the routes from the assignment using Postman
* All responses should be in JSON format.


* Run the server with `ruby bin/server.rb`
  * Please note: The server will need to be restarted every time you change your code.
* The server file _should_ be loading all your files in `app/controllers` and `app/models`. It has also loaded `pry` and `json` for you.


* You will be using the Postman app for any requests that are not `GET` requests.
* All `GET` requests can be displayed directly in the browser by navigating to the URL requested.
* In the assignment instructions, if the type of the request is not specified, it can be assumed to be `GET`.


## Defining Routes

- In `config/router.rb` you will write your routes using the private methods that are provided.
- If a route takes an id, you can't create a route for every possible number, so you will use a 'dynamic route'.
- A 'dynamic route' looks like this `:id` and the router will look for anything that fits inside of that.
- If you had a route defined like this `get('/posts/:id, PostsController, :show)` then it would match these urls:
  - `/posts/1`
  - `/posts/2/edit` <- You probably dont want your show route to match your edit route and thats why..
- **Orders matters** with routes in the route file. They are searched from top to bottom and the search stops the first time the router finds a valid route.
- So your _most specific_ routes need to go first.
- API and Resource routes will be separated.

```rb
def route
  [
    api_resource('api/posts',    APIPostsController),
    api_resource('api/comments', APICommentsController),

    resource("posts",    PostsController),
    resource("comments", CommentsController),# This is to demo the new redirect_to method

    get('/assets/:type/:name', AssetsController, :handle)
  ].flatten.find(&:itself)
end
```
## Creating a controller

- All controllers should exist inside of `app/controllers/` and their name should follow a pattern. `posts_controller.rb`
- Notice that 'tweets' is plural.
- The class must also inherit from `ApplicationController` to work properly with the router.
- A `ports_controller.rb` and `comments_controller.rb`would look something like this:

```rb
class PortsController < ApplicationController
  def index #Get
    @posts = App.posts
    render_template 'posts/index.html.erb'
  end

  def show #Get
    post = find_post_by_id

    if post
      @post = post
      @comments = App.comments.select { |comment| comment.post_id == post.id }
      render_template 'posts/show.html.erb'
    else
      render_not_found
    end
end

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
end
```
##These controllers will be achieving the following tasks:
- As a user of the site, I should be able to see all the posts from the root url ("/"). (The same data that would be on the posts#index).
- As a user of the site, I should be able to click the title of a post on the post index page and be navigated to the post show page.
- As a user of the site, I should be able to visit an individual post and see the body of the post and all the comments for that post (The show page for the post should include the comments for that post).
- As a user of the site, I should be able to create a new post by filling in the title and the body. (published should default to false).
Creating a post should redirect to to the show page for that post.
- As a user of the site, I should be able to create a new comment by filling in the body and picking the post I am commenting on from a dropdown or specifying the id.
- As a front end developer wanting to use your app's data to power my app, I should be able to access all crud actions for posts and comments.
