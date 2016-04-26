module BlackhawkApi
  module Responses
    # Response object after reading account transactions
    class AccountTransactionListResponse < BaseResponse
      attr_reader :total, :results

      def initialize(http_response)
        super(http_respnse.code, http_response.headers, http_response.raw_body)
      end

      protected

      def parse(object)
        @total = object.total
        @results = object.results.map { |v| AccountTransactionSummary.new(v) }
      end
    end
  end
end