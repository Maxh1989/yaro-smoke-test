require 'spec_helper'

RSpec.describe 'Communication Preferences Smoke Tests', :yaro, :notifications do
  include_context 'smoke-test-helpers'

  let(:communication_preferences_query) do
    %(query {
        communication_preferences {
          email_notifications
          push_notifications
          hsa_notifications
        }
      })
  end

  context 'User 1' do
    let(:access_token) { get_access_token('ashley.maxwell@example.com', 'testuser1') }

    context 'GraphQL' do
      let(:response) { graphql_response(graphql_url, communication_preferences_query, access_token) }

      it 'should return success' do
        expect(response.code).to eq(200)
      end

      it "returns the user's user plan information" do
        communication_preferences = parse_response_data(response)
        expected_communication_preferences = {
          'communication_preferences' => {
            'email_notifications' => true,
            'push_notifications' => true,
            'hsa_notifications' => true
          }
        }

        expect(communication_preferences).to eq(expected_communication_preferences)
      end
    end
  end

  context 'User 1' do
    let(:access_token) { get_access_token('joshua.cole@example.com', 'testuser2') }

    context 'GraphQL' do
      let(:response) { graphql_response(graphql_url, communication_preferences_query, access_token) }

      it 'should return success' do
        expect(response.code).to eq(200)
      end

      it "returns the user's user plan information" do
        communication_preferences = parse_response_data(response)
        expected_communication_preferences = {
          'communication_preferences' => {
            'email_notifications' => false,
            'push_notifications' => true,
            'hsa_notifications' => true
          }
        }

        expect(communication_preferences).to eq(expected_communication_preferences)
      end
    end
  end

  context 'User 3' do
    let(:access_token) { get_access_token('dean.cole@example.com', 'testuser3') }

    context 'GraphQL' do
      let(:response) { graphql_response(graphql_url, communication_preferences_query, access_token) }

      it 'should return success' do
        expect(response.code).to eq(200)
      end

      it "returns the user's user plan information" do
        communication_preferences = parse_response_data(response)
        expected_communication_preferences = {
          'communication_preferences' => {
            'email_notifications' => false,
            'push_notifications' => false,
            'hsa_notifications' => false
          }
        }

        expect(communication_preferences).to eq(expected_communication_preferences)
      end
    end
  end
end
