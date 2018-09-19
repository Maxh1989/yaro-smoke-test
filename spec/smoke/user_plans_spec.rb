require 'spec_helper'

RSpec.describe 'User Plans Smoke Test', :yaro, :platform do
  include_context 'smoke-test-helpers'

  let(:user_plans_query) do
    %(query {
        user_plans {
          coverage_start_date
          coverage_end_date
          rel_to_subscriber
          benefit_type
          coverage_level
          ins_subscriber_id
          member_id
        }
      })
  end

  context 'User 1' do
    let(:access_token) { get_access_token('ashley.maxwell@example.com', 'testuser1') }

    context 'GraphQL' do
      let(:response) { graphql_response(graphql_url, user_plans_query, access_token) }

      it 'should return success' do
        expect(response.code).to eq(200)
      end

      it "returns the user's user plan information" do
        user_plans = JSON.parse(response.body)['data']
        expected_user_plans = {
          'user_plans' => [
            'coverage_start_date' => '2018-05-01',
            'coverage_end_date' => '2019-04-01',
            'rel_to_subscriber' => 0,
            'benefit_type' => 'Medical',
            'coverage_level' => 'EO',
            'ins_subscriber_id' => 'DEAY6509301683755',
            'member_id' => 'DEAY6509301683755 001'
          ]
        }

        expect(user_plans).to eq(expected_user_plans)
      end
    end
  end

  context 'User 2' do
    let(:access_token) { get_access_token('joshua.cole@example.com', 'testuser2') }

    context 'GraphQL' do
      let(:response) { graphql_response(graphql_url, user_plans_query, access_token) }

      it 'should return success' do
        expect(response.code).to eq(200)
      end

      it "returns the user's user plan information" do
        user_plans = JSON.parse(response.body)['data']
        expected_user_plans = {
          'user_plans' => [
            'coverage_start_date' => '2018-05-01',
            'coverage_end_date' => '2019-04-01',
            'rel_to_subscriber' => 0,
            'benefit_type' => 'Medical',
            'coverage_level' => 'EC',
            'ins_subscriber_id' => 'FEAG2755380568988',
            'member_id' => 'FEAG2755380568988 001'
          ]
        }

        expect(user_plans).to eq(expected_user_plans)
      end
    end
  end

  context 'User 3' do
    let(:access_token) { get_access_token('dean.cole@example.com', 'testuser3') }

    context 'GraphQL' do
      let(:response) { graphql_response(graphql_url, user_plans_query, access_token) }

      it 'should return success' do
        expect(response.code).to eq(200)
      end

      it "returns the user's user plan information" do
        user_plans = JSON.parse(response.body)['data']
        expected_user_plans = {
          'user_plans' => [
            'coverage_start_date' => '2018-05-01',
            'coverage_end_date' => '2019-04-01',
            'rel_to_subscriber' => 2,
            'benefit_type' => 'Medical',
            'coverage_level' => 'EC',
            'ins_subscriber_id' => 'FEAG2755380568988',
            'member_id' => 'FEAG2755380568988 002'
          ]
        }

        expect(user_plans).to eq(expected_user_plans)
      end
    end
  end
end
