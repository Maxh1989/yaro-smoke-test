require 'json'
require 'base64'

class Alegeustesthelpers
   attr_accessor :tpaId, :employerId, :participantId, :dependentId
   def initialize
      @tpaId = "T02891"
      @employerId = "YROEGG"
      @participantId = "123159147"
      @dependentId = "12315914702"
   end

   def get_endpoints
     ["https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/employee/#{@tpaId}/#{@employerId}/#{@participantId}?decrypt=0",
                      "https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/employee/enrollment/#{@tpaId}/#{@employerId}/#{@participantId}?decrypt=0",
                      "https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/hsa/bankaccounts/#{@tpaId}/#{@employerId}/#{@participantId}/PNC?decrypt=0",
                      "https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/dependent/#{@tpaId}/#{@employerId}/#{@participantId}?decrypt=0",
                      "https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/dependent/#{@tpaId}/#{@employerId}/#{@participantId}/#{@dependentId}?decrypt=0",
                      "https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/cards/summary/#{@tpaId}/#{@employerId}/#{@participantId}?decrypt=0&filterflag=0",
                      "https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/cards/details/#{@tpaId}/#{@employerId}/#{@participantId}?card=1100048093114233&decrypt=0",
                      "https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/cards/pin/#{@tpaId}/#{@employerId}/#{@participantId}?card=1100048093114233&decrypt=0",
                      "https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/accounts/summary/#{@tpaId}/#{@employerId}/#{@participantId}?planyear=1&decrypt=0&accountdetail=''&externalbank=''&optinstatus=''",
                      "https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/accounts/details/#{@tpaId}/#{@employerId}/#{@participantId}?flexaccountkey=2&accttypecode=FSA&decrypt=0",
                      "https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/receipts/#{@tpaId}/#{@employerId}/#{@participantId}?filekey=4&decrypt=0",
                      "https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/claims/#{@tpaId}/#{@employerId}/#{@participantId}?decrypt=0&opt=0",
                      "https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/reimbursements/#{@tpaId}/#{@employerId}/#{@participantId}?recordcount=100&decrypt=0",
                      "https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/reimbursements/pending/#{@tpaId}/#{@employerId}/#{@participantId}?recordcount=100&decrypt=0",
                      "https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/transactions/recent/#{@tpaId}/#{@employerId}/#{@participantId}?flexAccountKey=2&recordCount=100&decrypt=0&includereceipts=0",
                      "https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/transactions/detailsex/#{@tpaId}/#{@employerId}/#{@participantId}?transactionid=1250001722-20180412-15044938&setldate=20180412&seqnum=1&decrypt=0&opt=0",
                      "https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/transactions/detailsex/#{@tpaId}/#{@employerId}/#{@participantId}?transactionid=1130000010-20180412-15060161&setldate=20180412&seqnum=1&decrypt=0&opt=0",
                      "https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/transactions/detailsex/#{@tpaId}/#{@employerId}/#{@participantId}?transactionid=2240005028-20180412-14502580&setldate=20180412&seqnum=1&decrypt=0&opt=0",
                      "https://beta.m.wealthcareadmin.com/ServiceProvider/services/participant/transactions/detailsex/#{@tpaId}/#{@employerId}/#{@participantId}?transactionid=1040005030-20180412-14541964&setldate=20180412&seqnum=1&decrypt=0&opt=0"]
   end

   def make_alegeus_token(header,payload,secret,lifetime,base64encoded=true)
    exp = Time.now.to_i - 10
    lifetime = lifetime  # seconds
    secret = secret
    if base64encoded
        hmac_secret =Base64.urlsafe_decode64(secret)
    else
        hmac_secret = secret
    end
    header = header
    payload = payload
    payload[:exp] = exp + lifetime
    payload[:nbf] = exp
    jwtheader64 = Base64.urlsafe_encode64(header.to_json)
    jwtpayload64 = Base64.urlsafe_encode64(payload.to_json).chomp[0...-2]
    signeddata = jwtheader64 + "." + jwtpayload64
    digest = OpenSSL::Digest.new('sha256')
    instance = OpenSSL::HMAC.digest(digest, hmac_secret, signeddata)
    signature = Base64.urlsafe_encode64(instance).chomp[0...-1]
    @token = signeddata + "."  + signature
  end

  def employee_dem_payload
 {
          "AddressLine1": "sample string 11",
          "AddressLine2": "sample string 12",
          "BirthDate": "1980-02-02",
          "City": "sample string 13",
          "Country": "sample string 16",
          "DriverLicenceNumber": "sample string 8",
          "Email": "aquane@alegeus.com",
          "FirstName": "sample string 2",
          "Gender": 0,
          "LastName": "sample string 3",
          "LastUpdated": "\/Date(1523565385454-0500)\/",
          "MaritalStatus": 0,
          "MiddleInitial": "sample string 4",
          "MiscData": {
            "BaseSalary": 1,
            "CitizenStatusCode": 1,
            "CitizenshipCountry": "sample string 1",
            "EmployerCity": "sample string 3",
            "EmployerName": "sample string 2",
            "EmployerState": "sample string 4",
            "EmployermentStatus": 1,
            "JobTitle": "sample string 5"
          },
          "MotherMaidenName": "sample string 7",
          "ParticipantId": "sample string 1",
          "Phone": "sample string 9",
          "ShippingAddressCity": "sample string 19",
          "ShippingAddressCountry": "sample string 22",
          "ShippingAddressLine1": "sample string 17",
          "ShippingAddressLine2": "sample string 18",
          "ShippingAddressState": "sample string 20",
          "ShippingAddressZip": "sample string 21",
          "State": "sample string 14",
          "Zip": "sample string 15"
        }
      end
      def add_bank_account_payload
    {
           "BankAccountName": "United Bank of America",
           "BankAccountNumber": "0123456789",
           "BankAccountStatusCdeEnumeration": -1,
           "BankAcctNickName": "UBA- Savings",
           "BankAcctTypeCdeEnumeration": 2,
           "BankRoutingNumber": "011103093",
           "ConfirmDte": "\/Date(1536861914198-0500)\/",
           "DataPartnerId": "PNC",
           "ExtBankAcctKey": -1,
           "TpaId": "T02891"
         }
      end

       #payload_account_contribution =
      def search_dependent_payload
   {
           "EmprId": "YROEGG",
           "MaxRecords": 10,
           "SearchBy": 2,
           "SearchFor": "Sleepy",
           "StartOrdinal": 1
         }
       end

      def card_trans_payload
{
               "Base64": "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",
               "ContentLength": 1,
               "ContentType": "PNG",
               "FileName": "MyReceipt.png",
               "InputStream": [
                 64,
                 64
               ],
               "FileFormat": 4096,
               "FileKey": 1
             }
        end




end
