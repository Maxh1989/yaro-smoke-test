require 'spec_helper'

RSpec.describe 'User Profile Smoke Test', :yaro, :platform do
  include_context 'smoke-test-helpers'

  let(:user_profile_query) do
    %(query {
        user_profile {
          first_name
          last_name
          gender
          date_of_birth
          address_line_1
          address_line_2
          city
          state
          zip_code
        }
      })
  end

  context 'User 1' do
    let(:access_token) { get_access_token('ashley.maxwell@example.com', 'testuser1') }

    context 'GraphQL' do
      let(:response) { graphql_response(graphql_url, user_profile_query, access_token) }

      it 'should return success' do
        expect(response.code).to eq(200)
      end

      it "returns the user's profile" do
        user_profile = JSON.parse(response.body)['data']
        expected_profile = {
          'user_profile' => {
            'first_name' => 'Ashley',
            'last_name' => 'Maxwell',
            'gender' => 'F',
            'date_of_birth' => '1986-11-08',
            'address_line_1'=> '03544 Christopher Corner',
            'address_line_2' => nil,
            'city' => 'Villaneuvaton',
            'state' => 'IL',
            'zip_code' => '60181'
          }
        }

        expect(user_profile).to eq(expected_profile)
      end
    end
  end

  context 'User 2' do
    let(:access_token) { get_access_token('joshua.cole@example.com', 'testuser2') }

    context 'GraphQL' do
      let(:response) { graphql_response(graphql_url, user_profile_query, access_token) }

      it 'should return success' do
        expect(response.code).to eq(200)
      end

      it "returns the user's profile" do
        user_profile = JSON.parse(response.body)['data']
        expected_profile = {
          'user_profile' => {
            'first_name' => 'Joshua',
            'last_name' => 'Cole',
            'gender' => 'M',
            'date_of_birth' => '1976-07-23',
            'address_line_1'=> '05327 Miller Point',
            'address_line_2' => 'Suite 619',
            'city' => 'Lake Nicolemouth',
            'state' => 'IL',
            'zip_code' => '60456'
          }
        }

        expect(user_profile).to eq(expected_profile)
      end
    end
  end

  context 'User 3' do
    let(:access_token) { get_access_token('dean.cole@example.com', 'testuser3') }

    context 'GraphQL' do
      let(:response) { graphql_response(graphql_url, user_profile_query, access_token) }

      it 'should return success' do
        expect(response.code).to eq(200)
      end

      it "returns the user's profile" do
        user_profile = JSON.parse(response.body)['data']
        expected_profile = {
          'user_profile' => {
            'first_name' => 'Dean',
            'last_name' => 'Cole',
            'gender' => 'M',
            'date_of_birth' => '2006-06-27',
            'address_line_1'=> '05327 Miller Point',
            'address_line_2' => 'Suite 619',
            'city' => 'Lake Nicolemouth',
            'state' => 'IL',
            'zip_code' => '60456'
          }
        }

        expect(user_profile).to eq(expected_profile)
      end
    end
  end
end
