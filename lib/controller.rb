require 'gossip'

class ApplicationController < Sinatra::Base

  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/:id' do
    id = params[:id].to_i 
    gossip = Gossip.find(id)
    erb :show_gossip, locals: {gossip: gossip}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id/edit_gossip' do
    id = params[:id].to_i 
    gossip = Gossip.find(id)
    erb :edit_gossip, locals: { gossip: gossip }
  end

  post '/gossips/:id/edit_gossip' do
    id = params[:id].to_i 
    gossip = Gossip.find(id)
    gossip.update(params["updated_author"], params["updated_content"])
    redirect '/'
  end
  
end
