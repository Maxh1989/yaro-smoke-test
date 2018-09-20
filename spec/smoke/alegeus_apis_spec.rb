require 'spec_helper'


RSpec.describe 'Alegeus Smoke Tests', :alegeus do

         helper = Alegeustesthelpers.new()
         get_endpoints= helper.get_endpoints
         tpaId = helper.tpaId
         employerId = helper.employerId
         participantId = helper.participantId
         dependentId = helper.dependentId
         payload_employee_demographic = helper.employee_dem_payload
         payload_add_bank_account = helper.add_bank_account_payload
         payload_search_dependent = helper.search_dependent_payload
         payload_card_trans = helper.card_trans_payload

  get_endpoints.each do |url|
    context 'alegeus get endpoints ' do
      context "url: #{url} with valid token " do
        let(:response) do
          token = helper.make_alegeus_token({"typ": "JWT","alg": "HS256"},{"tpaid": "T02891","iss": "WCP","aud": "https://beta.wealthcareadmin.com/serviceprovider/services"},'VDAyODkxTidKPTheKmRXXW1nXSVVP20s',3600)
          puts url
          RestClient.get(url,{Authorization:"Bearer #{token}"})
        rescue RestClient::ExceptionWithResponse => e
          e.response
        end
        it 'should return success' do
          expect(response.code).to eq(200)
        end
      end
      context "url: #{url} with invalid token " do
        let(:response) do
          token = "badtoken"
          RestClient.get(url,{Authorization:"Bearer #{token}"})
        rescue RestClient::ExceptionWithResponse => e
          e.response
        end
        it 'should return unauthorized' do
          expect(response.code).to eq(401)
        end
      end
    end
  end


  context 'alegeus add employee demographic ' do
    context "with valid token " do
      let(:response) do
        token = helper.make_alegeus_token({"typ": "JWT","alg": "HS256"},{"tpaid": "T02891","iss": "WCP","aud": "https://beta.wealthcareadmin.com/serviceprovider/services"},'VDAyODkxTidKPTheKmRXXW1nXSVVP20s',3600)
        RestClient.post("https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/employee/enrollment/#{tpaId}/#{employerId}/123159148?decrypt=0",payload_employee_demographic,{Authorization:"Bearer #{token}"})
      rescue RestClient::ExceptionWithResponse => e
        e.response
      end
      it 'should return success' do
        expect(response.code).to eq(403)
      end
    end
    context "with invalid token " do
      let(:response) do
        token = "badtoken"
        RestClient.post("https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/employee/enrollment/#{tpaId}/#{employerId}/123159148?decrypt=0",payload_employee_demographic,{Authorization:"Bearer #{token}"})
      rescue RestClient::ExceptionWithResponse => e
        e.response
      end
      it 'should return unauthorized' do
        puts response.code
        expect(response.code).to eq(401)
      end
    end
  end


  context 'alegeus add employee bank account ' do
    context "with valid token " do
      let(:response) do
        token = helper.make_alegeus_token({"typ": "JWT","alg": "HS256"},{"tpaid": "T02891","iss": "WCP","aud": "https://beta.wealthcareadmin.com/serviceprovider/services"},'VDAyODkxTidKPTheKmRXXW1nXSVVP20s',3600)
        RestClient.post("https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/hsa/bankaccounts/#{tpaId}/#{employerId}/#{participantId}?decrypt=0",payload_add_bank_account,{Authorization:"Bearer #{token}"})
      rescue RestClient::ExceptionWithResponse => e
        e.response
      end
      it 'should return success' do
        expect(response.code).to eq(403)
      end
    end
    context "with invalid token " do
      let(:response) do
        token = "badtoken"
        RestClient.post("https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/hsa/bankaccounts/#{tpaId}/#{employerId}/#{participantId}?decrypt=0",payload_add_bank_account,{Authorization:"Bearer #{token}"})
      rescue RestClient::ExceptionWithResponse => e
        e.response
      end
      it 'should return unauthorized' do
        puts response.code
        expect(response.code).to eq(401)
      end
    end
  end

  context 'alegeus add account contribution ' do
    context "with valid token " do
      let(:response) do
        token = helper.make_alegeus_token({"typ": "JWT","alg": "HS256"},{"tpaid": "T02891","iss": "WCP","aud": "https://beta.wealthcareadmin.com/serviceprovider/services"},'VDAyODkxTidKPTheKmRXXW1nXSVVP20s',3600)
        RestClient.post("https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/hsa/contributions/#{tpaId}/#{employerId}/#{participantId}?decrypt=0",payload_account_contribution,{Authorization:"Bearer #{token}"})
      rescue RestClient::ExceptionWithResponse => e
        e.response
      end
      it 'should return success' do
        expect(response.code).to eq(200)
      end
    end
    context "with invalid token " do
      let(:response) do
        token = "badtoken"
        RestClient.post("https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/hsa/bankaccounts/#{tpaId}/#{employerId}/#{participantId}?decrypt=0",payload_account_contribution,{Authorization:"Bearer #{token}"})
      rescue RestClient::ExceptionWithResponse => e
        e.response
      end
      it 'should return unauthorized' do
        puts response.code
        expect(response.code).to eq(401)
      end
    end
  end

  context 'alegeus search employee dependent ' do
    context "with valid token " do
      let(:response) do
        token = helper.make_alegeus_token({"typ": "JWT","alg": "HS256"},{"tpaid": "T02891","iss": "WCP","aud": "https://beta.wealthcareadmin.com/serviceprovider/services"},'VDAyODkxTidKPTheKmRXXW1nXSVVP20s',3600)
        RestClient.post("https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/dependent/#{tpaId}?decrypt=0",payload_search_dependent,{Authorization:"Bearer #{token}"})
      rescue RestClient::ExceptionWithResponse => e
        e.response
      end
      it 'should return success' do
        expect(response.code).to eq(200)
      end
    end
    context "with invalid token " do
      let(:response) do
        token = "badtoken"
        RestClient.post("https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/dependent/#{tpaId}?decrypt=0",payload_search_dependent,{Authorization:"Bearer #{token}"})
      rescue RestClient::ExceptionWithResponse => e
        e.response
      end
      it 'should return unauthorized' do
        puts response.code
        expect(response.code).to eq(401)
      end
    end
  end

  context 'alegeus issue new card ' do
    context "with valid token " do
      let(:response) do
        token = helper.make_alegeus_token({"typ": "JWT","alg": "HS256"},{"tpaid": "T02891","iss": "WCP","aud": "https://beta.wealthcareadmin.com/serviceprovider/services"},'VDAyODkxTidKPTheKmRXXW1nXSVVP20s',3600)
        RestClient.post("https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/cards/new/#{tpaId}/#{employerId}/#{participantId}?dep=12315914701&status=1&decrypt=0",{},{Authorization:"Bearer #{token}"})
      rescue RestClient::ExceptionWithResponse => e
        e.response
      end
      it 'should return 400 for already issuing a card to this user ' do
        expect(response.code).to eq(400)
      end
    end
    context "with invalid token " do
      let(:response) do
        token = "badtoken"
        RestClient.post("https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/cards/new/#{tpaId}/#{employerId}/#{participantId}?dep=12315914701&status=1&decrypt=0",{},{Authorization:"Bearer #{token}"})
      rescue RestClient::ExceptionWithResponse => e
        e.response
      end
      it 'should return unauthorized' do
        puts response.code
        expect(response.code).to eq(401)
      end
    end
  end

  context 'alegeus put card transaction receipt ' do
    context "with valid token " do
      let(:response) do
        token = helper.make_alegeus_token({"typ": "JWT","alg": "HS256"},{"tpaid": "T02891","iss": "WCP","aud": "https://beta.wealthcareadmin.com/serviceprovider/services"},'VDAyODkxTidKPTheKmRXXW1nXSVVP20s',3600)
        puts token
        RestClient.put("https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/receipts/pos//#{tpaId}/#{employerId}/#{participantId}?transactionid=1250001722-20180412-15044938&setldate=20180412}&seqnum=1&decrypt=0",payload_card_trans,{Authorization:"Bearer #{token}"})
      rescue RestClient::ExceptionWithResponse => e
        e.response
      end
      it 'should return 200' do
        expect(response.code).to eq(200)
      end
    end
    context "with invalid token " do
      let(:response) do
        token = "badtoken"
        RestClient.put("https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/receipts/pos//#{tpaId}/#{employerId}/#{participantId}?transactionid=1250001722-20180412-15044938&setldate=20180412}&seqnum=1&decrypt=0",payload_card_trans,{Authorization:"Bearer #{token}"})
      rescue RestClient::ExceptionWithResponse => e
        e.response
      end
      it 'should return unauthorized' do
        puts response.code
        expect(response.code).to eq(401)
      end
    end
  end


end
