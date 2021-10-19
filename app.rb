# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'pg'
require './lib/user.rb'
require './database_connection_setup.rb'
require 'sinatra/flash'
require 'sinatra/partial'
require 'pg'
require './lib/space'

class MakersBNB < Sinatra::Base
  
  
  configure :development do
    register Sinatra::Reloader
    register Sinatra::Flash
    register Sinatra::Partial
  end

  enable :sessions, :method_override, :partial_underscores
  set :partial_template_engine, :erb


  before do
    @user = User.find(session[:user_id])
  end

  get '/spaces' do
    erb :'spaces/all'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  post '/new-space' do
    Space.create(name: params[:name], description: params[:description], price: params[:price], available_from: params[:availablefrom_date], available_to: params[:availableto_date], user_id: @user.id)
    redirect '/spaces'
  end

  get '/spaces/new/id' do
    # @name = session[:name]
    # @description = session[:description]
    # @price = session[:price]
    # @availablefrom = session[:availablefrom]
    # @availableto = session[:availableto]
    erb :'spaces/new/id'
  end
  

  post '/sessions' do
    @user = User.authenticate(email_address: params[:email_address], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect('/')
    else
      redirect('/session_error')
    end
  end

  get '/session_error' do
    "Please check your email or password."
  end

   post '/users' do
    user = User.create(name: params[:name], email_address: params[:email_address], 
password: params[:password])
    session[:user_id] = user.id
    redirect '/'
  end

  get('/') do
    erb :index
  end

  post '/sessions/destroy' do
    session.clear
    redirect '/'
  end


  get ('/requests') do

  end

  run! if app_file == $PROGRAM_NAME

end