require 'pry'
require 'sinatra/base'
require './config/data_mapper'

class MakersBnB < Sinatra::Base
  enable :sessions
  enable :method_override

  ENV['RACK_ENV'] ||= 'development'

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    user = User.create(email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect '/profile'
  end

  get '/profile' do
    @user = User.get(session[:user_id])
    erb :profile
  end
end
