require 'sinatra/base'

class ApplicationController < Sinatra::Base

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
end
