require 'faraday'
require 'faraday/net_http'

Faraday.default_adapter = :net_http

class Request
  RMS_HOST = 'https://rms-api.preview.welltravel.com'

  def initialize(job_id, token, body)
    @conn = new_connection(token)
    @job_id = job_id
    @body = body
  end

  def self.call(job_id, token, body)
    new(job_id, token, body).call
  end

  def call
    do_request
  end

  private

  attr_reader :conn, :job_id, :body

  def do_request
    res = conn.post(apply_url) do |req|
      req.body = body.to_json
    end

    { status: res.status, body: res.body }
  end

  def apply_url
    "/api/job_posts/#{job_id}/apply"
  end

  def new_connection(token)
    Faraday.new(
      url: RMS_HOST,
      headers: {
        'Content-Type' => 'application/json',
        'Accept-Version' => 'v1',
        'Auhtorization' => token
      }
    )
  end
end
