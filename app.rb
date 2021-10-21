# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'pg'
require './lib/user'
require './database_connection_setup'
require 'sinatra/flash'
require './lib/booking'
require 'sinatra/partial'
require 'pg'
require './lib/space'
require './lib/booking_calendar'
require './helpers/spaces_helper'

class MakersBNB < Sinatra::Base

  include SpaceHelper

  configure :development do
    register Sinatra::Reloader
    register Sinatra::Flash
    register Sinatra::Partial
  end

  enable :sessions, :method_override, :partial_underscores
  set :partial_template_engine, :erb

  before do
    @user = User.find(id: session[:user_id])
  end

  get '/spaces' do
    booking_date = params['booking_date']
    if booking_date == nil || booking_date == ""
      @spaces = Space.all
    else
      @spaces = Space.filter(date: booking_date)
    end
    erb :'spaces/all'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  get '/spaces/:id/view' do
    @space = Space.find(id: params[:id]).first
    space_id = params[:id]
    @availability = BookingCalendar.availability(space_id: space_id)
    erb :'view_space'
  end

  get '/spaces/:id/edit' do
    @space = Space.find(id: params[:id]).first
    space_id = params[:id]
    @availability = BookingCalendar.availability(space_id: space_id)
    erb :'spaces/edit'
  end

  post '/edit-space' do
    @space = Space.find(id: params[:space_id]).first
    @new_space = Space.new(id: params[:id], name: params[:name], description: params[:description], price: params[:price], available_from: @space.available_from, available_to: @space.available_to, user_id: @space.id, url: params[:url])
    Space.update(space: @new_space)
    redirect "/spaces/#{@space.id}/view"
  end

  post '/new-space' do
    @space = Space.create(name: params[:name], description: params[:description], price: params[:price],
                 available_from: params[:availablefrom_date], available_to: params[:availableto_date], user_id: @user.id, url: params[:image_url])

    BookingCalendar.create(
      space_id: @space.id,
      start_date: params[:availablefrom_date],
      end_date: params[:availableto_date]
      )
    redirect '/spaces'
  end

  get '/spaces/my-spaces' do
    if @user
      @spaces = Space.mine(id: @user.id)
      erb :'spaces/all'
    else
      redirect('/permission_error')
    end
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
    erb :'errors/sessions'
  end

  post '/users' do
    user = User.create(name: params[:name], email_address: params[:email_address],
                       password: params[:password])
    session[:user_id] = user.id
    redirect '/'
  end

  get '/' do
    erb :index
  end

  post '/sessions/destroy' do
    session.clear
    redirect '/'
  end

  get '/requests' do
    if @user 
      @my_requests = Booking.find_my_requests(id: @user.id)
      @incoming_requests = Booking.all_incoming(id: @user.id)
      erb :requests
    else
      redirect('/permission_error')
    end
  end

  post '/bookings/new' do
    if session[:user_id]
      booking = Booking.create(start_date: params[:start_date], end_date: params[:end_date], booking_confirmed: false, user_id: session[:user_id], space_id: params[:space_id], host_id: params[:host_id])
      redirect '/requests'
    else
      redirect '/permission_error' 
    end
  end

  get '/permission_error' do
    erb :'errors/permissions'
  end

  post '/confirm-booking' do
    p params
    Booking.confirm(id: params["booking_id"])
    Booking.change_availability(id: params["space_id"], date: params["request_date"])
    Booking.cancel_competing_requests(id: params["space_id"], date: params["request_date"], booking_id: params["booking_id"])
    redirect('/requests')
  end

  post '/deny-booking' do
    Booking.deny(id: params["booking_id"])
    redirect('/requests')
  end



  run! if app_file == $PROGRAM_NAME
end
