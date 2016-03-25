require 'veto'

module BlackhawkApi
  class CorrelateAccountTransactionsRequestValidator
    include Veto.validator
  end
  
  class CreateAccountRequestValidator
    include Veto.validator
  end
  
  class CreateAccountTransactionRequestValidator
    include Veto.validator
  end
end