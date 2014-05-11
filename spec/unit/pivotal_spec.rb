require 'spec_helper'

describe Pivotal do
  it 'returns a list of all the projects' do

    VCR.use_cassette("projects") do

      api_url = Pivotal.new('https://www.pivotaltracker.com', '/services/v5/projects/')
      api_connection = api_url.faraday_connection
      api_response = api_url.faraday_response(api_connection)
      json_data = JSON.parse(api_response.body)
      project_data = json_data

      expect(project_data.first["name"]).to eq("Tracker API")
    end
  end

  it 'returns a list of all the stories' do

    VCR.use_cassette("stories") do

      tracker_project_id = 1077080
      api_url = Pivotal.new('https://www.pivotaltracker.com', "/services/v5/projects/#{tracker_project_id}/stories/")
      api_connection = api_url.faraday_connection
      api_response = api_url.faraday_response(api_connection)
      json_data = JSON.parse(api_response.body)
      story_data = json_data

      expect(story_data.first["name"]).to eq("As a user, I can view all of my projects")
    end
  end

  it 'returns a list of all the comments' do

    VCR.use_cassette("comments") do

      tracker_project_id = 1077080
      tracker_project_story_id = 71035108
      api_url = Pivotal.new('https://www.pivotaltracker.com', "/services/v5/projects/#{tracker_project_id}/stories/#{tracker_project_story_id}/comments")
      api_connection = api_url.faraday_connection
      api_response = api_url.faraday_response(api_connection)
      json_data = JSON.parse(api_response.body)
      comment_data = json_data

      expect(comment_data.first["text"]).to eq("This is a comment on the comment story")
    end
  end
end
