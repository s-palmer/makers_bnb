# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'pg'

class MakersBnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  run! if app_file == $PROGRAM_NAME

end