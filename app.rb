# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'pg'
require './lib/user.rb'
require './database_connection_setup.rb'
require 'sinatra/flash'


class MakersBNB < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  configure :development do
    register Sinatra::Reloader
  end

  get('/') do
    @user = User.find(session[:user_id])
    erb :index
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






  run! if app_file == $PROGRAM_NAME

end