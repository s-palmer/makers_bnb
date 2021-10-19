# frozen_string_literal: true

require 'auth_helper'

feature 'Adding a new Space' do
  scenario 'User can add a new space' do
  create_user_and_sign_in
  click_link('New Space')
  new_space_creation
  expect(page).to have_content('Hertfordshire Hideaway')
  expect(page).to have_content('It is pretty hidden')
  expect(page).to have_content('£75')
  expect(page).to have_content('Available From: Thu 21 October 2021')
  expect(page).to have_content('Available To: Sat 30 October 2021')
  end
end
