class Pivotal
  def initialize(base_url, api_url)
    @base_url = base_url
    @api_url = api_url
  end

  def faraday_connection
    connection = Faraday.new(:url => @base_url) do |faraday|
      faraday.request :url_encoded # form-encode POST params
      #faraday.response :logger # log requests to STDOUT
      faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
    end
    connection
  end

  def faraday_response(connection)
    response = connection.get do |req|
      req.url @api_url
      req.headers['X-TrackerToken'] = ENV['TRACKER_TOKEN']
    end
    response
  end
end
