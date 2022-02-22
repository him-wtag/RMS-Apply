# Script RMS

## Steps

- run `bundle install`
- run `ruby script.rb`

## Instruction

If we would like to apply to a different step with different data, update the `request_body` method inside `script.rb`

## How it will work

- It will parse the `data.json` file
- Read `id` from `id`
- Read `job_id` from candidate email `job_post_27_candidate_48@gmail.com`, assuming the third portion is job id, `27`
- Read `token`
- Send a post request to apply job id url, with the request_body
