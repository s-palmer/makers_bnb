require 'web_helpers'

feature 'Viewing Spaces' do
  scenario 'User should be able to view all available spaces' do
    create_user_and_sign_in
    click_link('New Space')
    new_space_creation
    click_link('All Spaces')
    expect(page).to have_text('Hertfordshire Hideaway', normalize_ws: true)
    expect(page).to have_text('It is pretty hidden', normalize_ws: true)
    expect(page).to have_text('£75', normalize_ws: true)
    expect(page).to have_text('From: Thu 21 Oct 2021', normalize_ws: true)
    expect(page).to have_text('To: Sat 30 Oct 2021', normalize_ws: true)
  end
end
