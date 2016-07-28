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
  erb :'account/new'
end

post '/account' do
  user = User.create(email: params[:email],
                     username: params[:user],
                     password: params[:pwd],
                     password_confirmation: params[:pwd_confirmation])
    if user.save
      session[:user_id] = user.id
      redirect '/links'
    else
      flash.now[:notice] = 'Password & confirmation password do not match'
      erb :'account/new'
    end
end

helpers do
  def current_user
    @current_user ||= User.get(session[:user_id])

  end

  def password_confirmation_error
    'please make sure password and confirmation match'
  end
end
    run! if app_file == $0
end
