class PivotalController < ApplicationController
  def index

  end

  def projects
    api_url = Pivotal.new('https://www.pivotaltracker.com', '/services/v5/projects/')
    api_connection = api_url.faraday_connection
    api_response = api_url.faraday_response(api_connection)
    json_data = JSON.parse(api_response.body)
    @project_data = json_data
  end

  def stories
    projects = self.projects
    selected_project = projects.select { |project| project["id"] == params[:id].to_i }
    @selected_project_name = selected_project.first["name"]

    api_url = Pivotal.new('https://www.pivotaltracker.com', "/services/v5/projects/#{params[:id]}/stories/")
    api_connection = api_url.faraday_connection
    api_response = api_url.faraday_response(api_connection)
    json_data = JSON.parse(api_response.body)
    @story_data = json_data

    selected_stories_ids = @story_data.select { |story| story["id"] }.collect { |story| story["id"] }
    @comment_data = self.comments(params[:id], selected_stories_ids)
  end

  def comments(project, stories)
    comments = []
    stories.each do |story|
      api_url = Pivotal.new('https://www.pivotaltracker.com', "/services/v5/projects/#{project}/stories/#{story}/comments")
      api_connection = api_url.faraday_connection
      api_response = api_url.faraday_response(api_connection)
      json_data = JSON.parse(api_response.body)
      if json_data.first
        comments << json_data.first["text"]
      end
    end
    comments
  end
end
