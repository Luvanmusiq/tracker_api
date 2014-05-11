require 'spec_helper'

feature 'view projects page' do
  scenario 'user can view all projects in Tracker account' do
    VCR.use_cassette("projects") do
      visit '/'
      click_on 'View Projects'

      expect(page).to have_content("Tracker API")
    end
  end

  scenario 'view all the stories for a project' do
    VCR.use_cassette("stories") do

      visit '/'
      click_on 'View Projects'
      click_on 'Tracker API'

      expect(page).to have_content("As a user, I can view all of my projects")
    end
  end

  scenario 'view all the Tracker comments for the stories of a project' do
    VCR.use_cassette("comments") do
      visit '/'
      click_on 'View Projects'
      click_on 'Tracker API'

      expect(page).to have_content("This is a comment on the comment story")
    end
  end
end

