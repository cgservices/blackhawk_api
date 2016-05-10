require 'blackhawk_api/client/entities/account_transaction_list'

module BlackhawkApi
  module Responses
    # Response object after reading account transactions
    class AccountTransactionListResponse < BaseResponse
      attr_reader :total, :results

      def initialize(http_response)
        super(http_response.code, http_response.headers, http_response.raw_body)
      end

      protected

      def parse(object)
        @total = object.total
        @results = object.results.map { |v| AccountTransactionList.new(v) }
      end
    end
  end
end