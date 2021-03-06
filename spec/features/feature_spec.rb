
describe Battle, :type => :feature do
  feature "Name input" do
    it "should return \"Let's battle!\"" do
      visit'/'
      expect(page).to have_content("Let's battle!")
    end

    it "should allow 2 players to enter names, submit, store as param and show their names" do
      sign_in_and_play
      expect(page).to have_content("Player One: Dave VS Player Two: Mittens")
    end
  end

  feature "Hit points" do
    it "should show a player's hit points" do
      sign_in_and_play
      expect(page).to have_content("Mittens : HP100")
    end
  end

  scenario "specifies which player's turn it is" do
    sign_in_and_play
    expect(page).to have_content("Dave's turn to attack.")
  end

  scenario "attack reduces player 2's points" do
    sign_in_and_play
    click_button("Attack!")
    expect(page).to have_content("Dave attacked Mittens!")
    expect(page).to have_content("Mittens : HP90")
  end

  scenario "after attacking, can go back to play" do
    sign_in_and_play
    click_button("Attack!")
    click_button("Back")
    expect(page).to have_content("Mittens : HP90")
  end

  scenario "after attacking, switch turns" do
    sign_in_and_play
    click_button("Attack!")
    click_button("Back")
    expect(page).not_to have_content("Dave's turn to attack.")
    expect(page).to have_content("Mittens's turn to attack.")
  end

  scenario "Shows 'Better luck next time' when i reach 0HP" do
    sign_in_and_play
    18.times do
      click_button("Attack!")
      click_button("Back")
    end
    click_button("Attack!")
    expect(page).to have_content("Mittens: Better luck next time")
  end
end
