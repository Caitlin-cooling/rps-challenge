require_relative '../../lib/game'

def sign_in_and_play
  visit '/'
  fill_in('name1', with: 'Caitlin')
  fill_in('name2', with: 'James')
  click_button("Let's play!")
end
