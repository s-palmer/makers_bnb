
require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'sinatra/partial'
require_relative 'database_connection_setup'

class MakersBNB < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
    register Sinatra::Flash
    register Sinatra::Partial
  end

  enable :sessions, :method_override, :partial_underscores
  set :partial_template_engine, :erb

  get '/spaces' do
    erb :'spaces/all'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  post '/new-space' do
    session[:name] = params['name']
    session[:description] = params['description']
    session[:price] = params['price']
    session[:availablefrom] = params['availablefrom-date']
    session[:availableto] = params['availableto-date']
    p params

    redirect 'spaces/new/id'
  end

  get '/spaces/new/id' do
    @name = session[:name]
    @description = session[:description]
    @price = session[:price]
    @availablefrom = session[:availablefrom]
    @availableto = session[:availableto]
    erb :'spaces/new/id'

  get ('/') do 
    "Welcome to MakersBnb"
  end

  get ('/login') do 

  end

  post ('/login') do 

  end

  get ('/requests') do

  end

  run! if app_file == $PROGRAM_NAME
end
