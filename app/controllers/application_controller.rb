require 'sinatra/base'
require 'plezi'

class SocketController
  CHANNEL = "chat".freeze
  # def index
  #   'sucking on them titties like you wanted them all the time'
  # end
  # Websockets
  def on_open
    subscribe CHANNEL
    write 'Welcome to chatroom!'
    @handle = params['id'.freeze] || 'Somebody'
    publish CHANNEL, "#{ERB::Util.html_escape @handle} joind us :-)"
  end
  def on_message(data)
    data = ERB::Util.html_escape data
    publish CHANNEL, data
  end

  def on_close
    publish CHANNEL, "#{@handle} left us :-("
  end


end

class ApplicationController < Sinatra::Base
  Plezi.route '/socket', SocketController
  use Plezi

  configure do
    enable :sessions
    set :session_secret, "Dankhouse"
    set :views, "app/views"
    set :public_dir, "public"
  end

  get '/' do
    erb :index
  end

  get '/queue' do
    if session[:name]
      @name = session[:name]
    end
    erb :queue
    # "Hello World"
  end

  post '/register' do
    @name = params["name"]
    session[:name] = params["name"]
    redirect "/queue"
  end

  get '/main.css' do
    scss :main
  end
end
