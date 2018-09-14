require 'json'

RSpec.shared_context 'smoke-test-helpers' do
  let(:platform_root_url) { ENV.fetch('PLATFORM_ROOT_URL') }
  let(:notifications_root_url) { ENV.fetch('NOTIFICATIONS_ROOT_URL') }
  let(:quiz_root_url) { ENV.fetch('QUIZ_ROOT_URL') }
  let(:oauth_token_url) { "#{platform_root_url}/oauth/token" }
  let(:graphql_url) { "#{platform_root_url}/api/v1/graphql" }

  def get_access_token(username, password)
    payload = {
      grant_type: 'password',
      username: username,
      password: password,
      scope: 'member'
    }
    response = RestClient.post(oauth_token_url, payload)
    JSON.parse(response.body)['access_token']
  end

  def graphql_response(url, query, access_token)
    RestClient.post(url, { query: query }, headers={ authorization: "Bearer #{access_token}" })
  end

  def rest_response(url, method, payload, headers={})
    RestClient.send(method, url, payload, headers)
  rescue RestClient::ExceptionWithResponse => e
    e.response
  end

  def parse_response_data(response)
    JSON.parse(response.body)['data']
  end
end
