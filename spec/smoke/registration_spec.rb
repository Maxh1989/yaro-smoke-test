require 'spec_helper'

RSpec.describe 'Registration Smoke Tests' do
  include_context 'smoke-test-helpers'

  context 'registration-code' do
    context 'with a valid code' do
      let(:response) do
        rest_response("#{platform_root_url}/api/v1/registration/registration-code",
                      :post,
                      { registration_code: '12345' })
      end

      it 'should return success' do
        expect(response.code).to eq(200)
      end
    end

    context 'with an invalid code' do
      let(:response) do
        rest_response("#{platform_root_url}/api/v1/registration/registration-code",
                      :post,
                      { registration_code: 'invalid-code' })
      end

      it 'should return not found' do
        expect(response.code).to eq(404)
      end

      it 'should include an error message' do
        expect(response.body).to include('Registration code not found')
      end
    end
  end

  context 'profile-verification' do
    context 'with a valid profile' do
      let(:response) do
        rest_response("#{platform_root_url}/api/v1/registration/profile-verification",
                      :post,
                      { registration_code: '12345',
                        member_id: 'TCLS8070293258512 001',
                        first_name: 'Ryan',
                        last_name: 'Collins',
                        date_of_birth: '1977-02-21',
                        zip_code: '35957' })
      end

      it 'should return success' do
        expect(response.code).to eq(200)
      end
    end

    context 'with an invalid registration code' do
      let(:response) do
        rest_response("#{platform_root_url}/api/v1/registration/profile-verification",
                      :post,
                      { registration_code: 'invalid-code',
                        member_id: 'TCLS8070293258512 001',
                        first_name: 'Ryan',
                        last_name: 'Collins',
                        date_of_birth: '1977-02-21',
                        zip_code: '35957' })
      end

      it 'should return not found' do
        expect(response.code).to eq(404)
      end

      it 'should include an error message' do
        expect(response.body).to include('Registration code not found')
      end
    end

    context 'with an invalid profile' do
      let(:response) do
        rest_response("#{platform_root_url}/api/v1/registration/profile-verification",
                      :post,
                      { registration_code: '12345',
                        member_id: 'TCLS8070293258512 001',
                        first_name: 'Ryan',
                        last_name: 'Collins',
                        date_of_birth: '1978-03-21', # wrong DOB
                        zip_code: '35957' })
      end

      it 'should return unprocessible entity' do
        expect(response.code).to eq(422)
      end

      it 'should include an error message' do
        expect(response.body).to include('Identity could not be verified')
      end
    end
  end
end
