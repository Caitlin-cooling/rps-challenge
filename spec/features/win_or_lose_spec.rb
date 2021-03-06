feature 'Win or lose' do
  player1 = Player.new("Caitlin")
  player2 = Player.new("James")
  Game.create(player1, player2)
  let(:players) { Game.players }
  let(:winner) { Winner.new(players) }

  before do
    sign_in_and_play
  end

  scenario 'player2 wins' do
    find_button('rock').click
    find_button('paper').click
    expect(page).to have_content winner.player2_won
  end

  scenario 'player1 wins' do
    find_button('scissors').click
    find_button('paper').click
    expect(page).to have_content winner.player1_won
  end

  scenario 'its a draw' do
    find_button('paper').click
    find_button('paper').click
    expect(page).to have_content winner.draw
  end
end
