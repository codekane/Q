require 'sinatra/base'
require 'plezi'

class SocketController
  ROOM = "room".freeze
  def on_open
    subscribe ROOM
    @user = params['name'.freeze] || 'mingebag'
    write @user
    publish ROOM, "#{ERB::Util.html_escape @user} joind us :-)"
  end
  def on_message(data)
    data = ERB::Util.html_escape data
    publish ROOM, data
  end

  def on_close
    publish ROOM, "#{@user} left us :-("
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
