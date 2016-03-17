require 'blackhawk_api/client/requests/base_request'

module BlackhawkApi
  class CreateAccountRequest < Request
    attr_reader :product_id, :amount, :currency, :transaction_time,
      :reference_number, :store_number, :terminal_number, 
      :base_transaction_id, :message_reason_code
    
    def initialize(product_id, amount, currency, transaction_time,
      reference_number, store_number, terminal_number, base_transaction_id,
      sort_key = nil, first = 0, ascending = true, maximum = 50)
      super(sort_key, first, ascending, maximum)
      
      @product_id = product_id
      @amount = amount
      @currency = currency
      @transaction_time = transaction_time
    end    
  end
  
  class AccountLookupRequest < Request
    attr_reader :account_number, :product_line_id, :account_type
    
    def initialize(account_number, product_line_id, account_type,
      sort_key = nil, first = 0, ascending = true, maximum = 50)
        super(sort_key, first, ascending, maximum)
        
        @account_number = account_number
        @product_line_id = product_line_id
        @account_type = account_type
    end
  end
  
  class CreateAccountTransactionRequest < Request
  end
  
  class FindAccountTransactionsByIdsRequest < PaginatedRequest
    attr_reader :transaction_ids
    
    def initialize(transaction_ids, sort_key, page_index, page_size)
      super(sort_key, page_index, page_size)
      
      @transaction_ids = transaction_ids
    end
  end
  
  class FindAccountTransactionsByAccountIdRequest < PaginatedRequest
    attr_reader :account_id
    
    def initialize(account_id, sort_key, page_index, page_size)
      super(sort_key, page_index, page_size)
      
      @account_id = account_id
    end
  end
  
  class FindAccountTransactionsByCorrelationIdRequest < PaginatedRequest
    attr_reader :correlation_id
    
    def initialize(correlation_id, sort_key, page_index, page_size)
      super(sort_key, page_index, page_size)
      
      @correlation_id = correlation_id
    end  
  end
  
  class CorrelateAccountTransactionsRequest < Request
    attr_reader :transaction_ids
    
    def initialize(transaction_ids)
      @transaction_ids = transaction_ids
    end
  end
end
