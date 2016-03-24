require 'webrick'
require 'socket'
require 'timeout'
require 'uri'
require 'erb'
require 'json'
require 'pry'
require_relative '../config/router'
require_relative '../app/controllers/application_controller'
require_relative '../lib/all'

module App
  # Place all data here inside of a method
  def App.posts
    # This is an example
    @all_posts ||= [
      (Post.new(1, "Learn Ruby on Rails", "Justin", "This a class to learn Ruby", true )),
      (Post.new(2, "Learn Ruby", "Vivek", "This a class to learn Ruby", true )),
      (Post.new(3, "Learn Ruby", "Colin", "This a class to learn Ruby", true )),
      (Post.new(4, "Learn Ruby", "Van", "This a class to learn Ruby", true )),
      (Post.new(5, "Learn Ruby", "Dane", "This a class to learn Ruby", true ))
    ]
  end

  def App.comments
    @all_comments ||= [
      (Comments.new(1,"This is great post.", "Brent", 1)),
      (Comments.new(2,"This can be also written like...", "Sally", 1)),
      (Comments.new(3,"This article really helped me.", "Dave", 2)),
      (Comments.new(4,"Look forward to next article.", "Jorden", 2)),
      (Comments.new(5,"You can read more on this here.", "Jerad", 3)),
    ]
  end

end

system('clear')

def start_custom_webbrick_server
  server = WEBrick::HTTPServer.new(Port: 3001)
  server.mount "/", WEBBrickServer

  trap(:INT)  { server.shutdown }
  trap(:TERM) { server.shutdown }

  puts "The server is running and awaiting requests at http://localhost:3001/"
  server.start
end

def start_custom_tcp_server
  CustomTCPServer.new.start
end


if ARGV[0] == '--no-webrick'
  start_custom_tcp_server
else
  start_custom_webbrick_server
end
