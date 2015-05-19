require 'rack'
require 'rack/lobster'
require 'byebug'

class HackLobster
  def initialize(app)
    @app = app
  end

  def call(env)
    # 1. What is this line doing? Why? Hint: see number 3 below.
    @status, @headers, @response = @app.call(env)

    # 5. What happens if we comment this line out?
    @headers["Content-Length"] = (@response.length + say_hello.length).to_s

    # 2. Why is this returning an array? Does the order matter?
    [@status, @headers, self]
  end

  def each(&block)
    # 3. Where does `block` come from?
    block.call(say_hello) # Check out the method defined below
    @response.each(&block)
  end

  private
  def say_hello
    # This is where you put your HTML
    # 4. Get it to output your name in the heading.
    #   * In the root of this directory, run `rackup`
    #   * This should start a server at http://localhost:9292
    #   * Note: You will need to restart your server if you edit this file
  end
end

run Rack::Lobster.new
use HackLobster
