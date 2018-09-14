require 'spec_helper'

RSpec.describe 'User Quiz Questions Smoke Test' do
  include_context 'smoke-test-helpers'

  let(:user_quiz_questions_query) do
    %(query {
        user_quiz_questions {
          question_name
          answer
        }
      })
  end

  context 'User 1' do
    let(:access_token) { get_access_token('ashley.maxwell@example.com', 'testuser1') }

    context 'GraphQL' do
      let(:response) { graphql_response(graphql_url, user_quiz_questions_query, access_token) }

      it 'should return success' do
        expect(response.code).to eq(200)
      end

      it "returns the user's user plan information" do
        user_quiz_questions = parse_response_data(response)
        expected_user_quiz_questions = {
          'user_quiz_questions' => [
            {
              'question_name' => 'hsa-familiarity',
              'answer' => 'sorta'
            }
          ]
        }

        expect(user_quiz_questions).to eq(expected_user_quiz_questions)
      end
    end
  end

  context 'User 2' do
    let(:access_token) { get_access_token('joshua.cole@example.com', 'testuser2') }

    context 'GraphQL' do
      let(:response) { graphql_response(graphql_url, user_quiz_questions_query, access_token) }

      it 'should return success' do
        expect(response.code).to eq(200)
      end

      it "returns the user's user plan information" do
        user_quiz_questions = parse_response_data(response)
        expected_user_quiz_questions = {
          'user_quiz_questions' => [
            {
              'question_name' => 'hsa-familiarity',
              'answer' => 'very!'
            }
          ]
        }

        expect(user_quiz_questions).to eq(expected_user_quiz_questions)
      end
    end
  end

  context 'User 3' do
    let(:access_token) { get_access_token('dean.cole@example.com', 'testuser3') }

    context 'GraphQL' do
      let(:response) { graphql_response(graphql_url, user_quiz_questions_query, access_token) }

      it 'should return success' do
        expect(response.code).to eq(200)
      end

      it "returns the user's user plan information" do
        user_quiz_questions = parse_response_data(response)
        expected_user_quiz_questions = {
          'user_quiz_questions' => []
        }

        expect(user_quiz_questions).to eq(expected_user_quiz_questions)
      end
    end
  end
end
