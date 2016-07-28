ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require './models/link'
require './models/user'
require_relative 'data_mapper_setup'


class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'

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
  user = User.create(email: params[:email], username: params[:user])
  user.set_password(params[:password])
  session[:user_id] = user.id
  redirect '/links'
end

helpers do
  def current_user
    @current_user ||= User.get(session[:user_id])

  end
end
    run! if app_file == $0
end
