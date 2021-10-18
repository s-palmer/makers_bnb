feature 'Viewing Spaces' do
  scenario 'User should be able to view all available spaces' do
    visit '/spaces'
    expect(page).to have_content('Space 1')
    expect(page).to have_content('Space 2')
    expect(page).to have_content('Space 3')
  end
end
