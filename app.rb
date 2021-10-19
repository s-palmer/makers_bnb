# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'pg'
require './lib/user.rb'
require './database_connection_setup.rb'
require 'sinatra/flash'



class MakersBNB < Sinatra::Base


  enable :sessions, :method_override, :partial_underscores
  set :partial_template_engine, :erb
  
  register Sinatra::Flash

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
  end
  
  get ('/sessions/new') do
    erb :"sessions/new"
  end

  post ('/sessions') do
    user = User.authenticate(email_address: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id
      redirect('/')
    else
      flash[:notice] = 'Please check your username or password.'
      redirect('/sessions/new')
    end
  end

  get('/') do
    @user = User.find(session[:user_id])
    erb :index
  end

  get ('/login') do 

  end

  post ('/login') do 

  end

  get ('/requests') do

  end

  run! if app_file == $PROGRAM_NAME

end