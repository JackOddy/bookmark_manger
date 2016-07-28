ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require './models/link'
require './models/user'
require 'sinatra/flash'
require_relative 'data_mapper_setup'


class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash
  use Rack::MethodOverride

 get '/links' do
    @links = Link.all
    erb :'links/index'
 end

 get '/links/new' do
    erb :'links/new'
 end

 post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    params[:tags].split.each do |tag|
    link.tags << Tag.create(name: tag)
  end
    link.save
    redirect '/links'
 end

get '/tags/:name' do
  tag = Tag.first(name: params[:name])
  @links = tag ? tag.links : []
  erb :'links/index'
end


get '/account/new' do
  @user = User.new
  erb :'account/new'
end

post '/account' do
  @user = User.create(email: params[:email],
                     password: params[:pwd],
                     password_confirmation: params[:pwd_confirmation])
  if @user.save
    session[:user_id] = @user.id
    redirect '/links'
  else
    flash.now[:errors] = @user.errors.full_messages
    erb :'account/new'
  end
end

get '/sessions/new' do
  erb :'/sessions/new'
end

post '/sessions' do
  user = User.authenticate(params[:email], params[:pwd])
  if user
    session[:user_id] = user.id
    redirect '/links'
  else
    flash.now[:errors] = ['The email or password is incorrect']
    erb :'/sessions/new'
  end
end

delete '/sessions' do
  session[:user_id] = nil
  flash.keep[:notice] = 'You have signed out'
  redirect to '/links'
end

helpers do
  def current_user
    @current_user ||= User.get(session[:user_id])

  end
end
    run! if app_file == $0
end
