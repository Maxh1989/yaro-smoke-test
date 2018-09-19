require 'spec_helper'

RSpec.describe 'Notifications Smoke Test', :yaro, :notifications do
  include_context 'smoke-test-helpers'

  let(:notifications_query) do
    %(query {
        notifications {
          headline
          in_app_notification {
            message
          }
        }
      })
  end

  context 'User 1' do
    let(:access_token) { get_access_token('ashley.maxwell@example.com', 'testuser1') }

    context 'GraphQL' do
      let(:response) { graphql_response(graphql_url, notifications_query, access_token) }

      it 'should return success' do
        expect(response.code).to eq(200)
      end

      it "returns the user's notifications" do
        user_notifications = JSON.parse(response.body)['data']
        expected_notifications = {
          'notifications' => [
            {
              'headline' => 'Your HSA balance has increased!',
              'in_app_notification' => {
                'message' => '$25 was added to your HSA.'
              }
            },
            {
              'headline' => 'You reached your max HSA contribution',
              'in_app_notification' => {
                'message' => 'Congratulations! You put in the maximum HSA contribution for 2018.'
              }
            },
          ]
        }

        expect(user_notifications).to eq(expected_notifications)
      end
    end
  end

  context 'User 2' do
    let(:access_token) { get_access_token('joshua.cole@example.com', 'testuser2') }

    context 'GraphQL' do
      let(:response) { graphql_response(graphql_url, notifications_query, access_token) }

      it 'should return success' do
        expect(response.code).to eq(200)
      end

      it "returns the user's notifications" do
        user_notifications = JSON.parse(response.body)['data']
        expected_notifications = {
          'notifications' => [
            {
              'headline' => "It's summer camp season!",
              'in_app_notification' => {
                'message' => 'Do your kids need a checkup before summer camp? Schedule a PCP visit today.'
              }
            },
            {
              'headline' => "It's time for your annual checkup!",
              'in_app_notification' => {
                'message' => 'Schedule an appointment with your PCP today.'
              }
            },
            {
              'headline' => "Don't miss out!",
              'in_app_notification' => {
                'message' => 'You can still contribute $1250 to your HSA this year.'
              }
            },
            {
              'headline' => 'You have an unpaid claim',
              'in_app_notification' => {
                'message' => 'View your claim and resolve any unpaid balance.'
              }
            }
      ]
        }

        expect(user_notifications).to eq(expected_notifications)
      end
    end
  end

  context 'User 3' do
    let(:access_token) { get_access_token('dean.cole@example.com', 'testuser3') }

    context 'GraphQL' do
      let(:response) { graphql_response(graphql_url, notifications_query, access_token) }

      it 'should return success' do
        expect(response.code).to eq(200)
      end

      it "returns the user's notifications" do
        user_notifications = JSON.parse(response.body)['data']
        expected_notifications = {
          'notifications' => []
        }

        expect(user_notifications).to eq(expected_notifications)
      end
    end
  end
end
