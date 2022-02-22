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

      job_id = read_job_id_from_email(candidate['email'])
      token = candidate['token']
      body = request_body(candidate)

      response = Request.call(job_id, token, body)

      file.write({ id: candidate['id'], status: response['status'], body: response['body'] })
    end
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
      "step_number": 3,
      "step_info": {
        "gender": 'Male',
        "religion": 'Buddhist',
        "father_name": 'Father1',
        "mother_name": 'Mother1',
        "nationality": 'Canadian',
        "date_of_birth": '25-01-1991',
        "marital_status": 'unmarried',
        "current_address": 'Dhaka'
      }
    }
  end
end

Script.call
