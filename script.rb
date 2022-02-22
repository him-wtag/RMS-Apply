require 'json'
require_relative 'request'

class Script
  def self.call
    new.call
  end

  def call
    file = File.open('log.txt', 'w')

    candidates_list.each do |data|
      candidate = JSON.parse(data)

      job_id = candidate['job_id']
      token = candidate['token']
      body = request_body(candidate)

      response = Request.call(job_id, token, body)
      file.write({ id: candidate['id'], status: response[:status], body: JSON.parse(response[:body]) })
      file.write("\n")
    end

    file.close

    puts 'Check the log.txt file for logs!'
  end

  private

  def candidates_list
    file = File.read('./data.json')
    JSON.parse(file)
  end

  def read_job_id_from_email(email)
    # email format 'job_post_28_candidate_8@gmail.com'
    email.split('_')[2]
  end

  def request_body(candidate)
    {
      "candidate_id": candidate['id'],
      "step_number": 7,
      "step_info": {
        "languages": %w[
          java
          python
          ruby
        ]

      }

    }
  end
end

Script.call
