require 'sinatra'
require 'sinatra/base'
require_relative './lib/players'
require_relative './lib/winner'
require_relative './lib/computer'

class RPS < Sinatra::Base

  get '/' do
    erb(:index)
  end

  get '/two_player' do
    erb(:two_player)
  end

  get '/one_player' do
    erb(:one_player)
  end

  post '/single_player_names' do
    @name1 = params[:name1]
    computer = Computer.new([:rock, :paper, :scissors, :lizard, :spock])
    @name2 = computer.name2
    @players = Players.create(@name1, @name2)
    @players.move2 = computer.move2
    redirect '/single_player_game'
  end

  get '/single_player_game' do
    @players = Players.instance
    @name1 = @players.name1
    @name2 = @players.name2
    @players.move1 = params["move1"]
    erb(:single_player_game)
  end

  post '/multiplayer_names' do
    @name1 = params[:name1]
    @name2 = params[:name2]
    @player1 = Players.new(@name1)
    @player2 = Players.new(@name2)
    @players = [@player1, @player2]
    redirect '/multiplayer_game'
  end

  get '/multiplayer_game' do
    @players = Players.all
    @name1 = @players.first.name
    @name2 = @players.last.name
    erb(:multiplayer_game)
  end

  post '/multiplayer_game' do
    @players = Players.all
    @players.move1 = params["move1"]
    redirect '/multiplayer_game2'
  end

  get '/multiplayer_game2' do
    @players = Players.all
    @name1 = @players.first.name
    @name2 = @players.last.name
    erb(:multiplayer_game2)
  end

  post '/game/determine' do
    @players = Players.instance
    @players.move1 = params["move1"] if @players.move1.nil?
    @players.move2 = params["move2"] if @players.move2.nil?
    redirect '/game/result'
  end

  get '/game/result' do
    @players = Players.instance
    @name1 = @players.name1
    @name2 = @players.name2
    @move1 = @players.move1
    @move2 = @players.move2
    @winner = Winner.new(@players)
    @determine_winner = @winner.determine
    erb(:result)
  end

  run! if app_file == $0
end
