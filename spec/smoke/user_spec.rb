require 'spec_helper'

RSpec.describe 'User Smoke Test' do
  include_context 'smoke-test-helpers'

  let(:user_query) do
    %(query {
        user {
          id
          email
        }
      })
  end

  context 'User 1' do
    let(:access_token) { get_access_token('ashley.maxwell@example.com', 'testuser1') }

    context 'GraphQL' do
      let(:response) { graphql_response(graphql_url, user_query, access_token) }

      it 'should return success' do
        expect(response.code).to eq(200)
      end

      it "returns the user's information" do
        user = JSON.parse(response.body)['data']
        expected_user = {
          'user' => {
            'id' => '390eaa77-5a25-4af2-8e9b-82b1a0771f79',
            'email' => 'ashley.maxwell@example.com'
          }
        }
        expect(user).to eq(expected_user)
      end
    end
  end

  context 'User 2' do
    let(:access_token) { get_access_token('joshua.cole@example.com', 'testuser2') }

    context 'GraphQL' do
      let(:response) { graphql_response(graphql_url, user_query, access_token) }

      it 'should return success' do
        expect(response.code).to eq(200)
      end

      it "returns the user's information" do
        user = JSON.parse(response.body)['data']
        expected_user = {
          'user' => {
            'id' => '69556df2-d1f5-41ef-a556-4bcc994df052',
            'email' => 'joshua.cole@example.com'
          }
        }
        expect(user).to eq(expected_user)
      end
    end
  end

  context 'User 3' do
    let(:access_token) { get_access_token('dean.cole@example.com', 'testuser3') }

    context 'GraphQL' do
      let(:response) { graphql_response(graphql_url, user_query, access_token) }

      it 'should return success' do
        expect(response.code).to eq(200)
      end

      it "returns the user's information" do
        user = JSON.parse(response.body)['data']
        expected_user = {
          'user' => {
            'id' => '51dd6468-7631-4cb2-83f3-d88e84884ff1',
            'email' => 'dean.cole@example.com'
          }
        }
        expect(user).to eq(expected_user)
      end
    end
  end
end
