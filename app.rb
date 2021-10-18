
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
