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
      (Post.new(1, "Learn Ruby on Rails", "Justin  Herrick", "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. ", true )),
      (Post.new(2, "Ruby Wizardry", "Weinstein", "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",           true )),
      (Post.new(3, "Clean Code", "Robert Martin", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce lorem nunc, tempus quis auctor sed, tincidunt vel justo. Donec et laoreet magna. Maecenas dignissim tristique elit",           true )),
      (Post.new(4, "Pratical Object-Oriented Design", "Sandi Metz", "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",             true )),
      (Post.new(5, "Simple isn't just that important", "David Heinemeier Hansson", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce lorem nunc, tempus quis auctor sed, tincidunt vel justo. Donec et laoreet magna. Maecenas dignissim tristique elit",            true ))
    ]
  end

  def App.comments
    @all_comments ||= [
      (Comment.new(1,"This is great post.", "Margerate Darbey", 1)),
      (Comment.new(2,"This can be also written like...", "Sally Martin", 1)),
      (Comment.new(3,"This article really helped me.", "Dave Ramsey", 2)),
      (Comment.new(4,"Look forward to next article.", "Peter Tucker", 2)),
      (Comment.new(5,"You can read more on this here.", "Adam Love", 3)),
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
