feature 'Adding a new Space' do
  scenario 'User can add a new space' do
    visit '/spaces/new'
    # connection = PG.connect(dbname: 'makers_bnb_test')
    # connection.exec_params("INSERT INTO users")
    fill_in('listing-name', with: 'Hertfordshire Hideaway')
    fill_in('listing-description', with: 'It is pretty hidden')
    fill_in('listing-price', with: '75')
    fill_in('listing-fromdate', with: '21/10/2021')
    fill_in('listing-todate', with: '30/10/2021')
    click_button('List my Space')
    expect(page).to have_content('Hertfordshire Hideaway')
    expect(page).to have_content('It is pretty hidden')
    expect(page).to have_content('£75')
    expect(page).to have_content('21/10/2021')
    expect(page).to have_content('30/10/2021')
  end
end