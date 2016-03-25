require "blackhawk_api/version"

# Include error values
require 'blackhawk_api/client/errors/blackhawk_api_error'

# Include value objects
require 'blackhawk_api/client/values/enumerations'
require 'blackhawk_api/client/values/blackhawk_identity'

# Include helper methods
require 'blackhawk_api/client/helpers/identity_extractor'

# Include request objects
require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/requests/account_requests'
require 'blackhawk_api/client/requests/catalog_requests'
require 'blackhawk_api/client/requests/gift_requests'
require 'blackhawk_api/client/requests/product_requests'

# Include validations
require 'blackhawk_api/client/validators/account_validators'
require 'blackhawk_api/client/validators/catalog_validators'
require 'blackhawk_api/client/validators/gift_validators'

# Include response objects
require 'blackhawk_api/client/responses/base_response'
require 'blackhawk_api/client/responses/account_responses'
require 'blackhawk_api/client/responses/gift_responses'
require 'blackhawk_api/client/responses/product_responses'

# Include REST Resources
require 'blackhawk_api/client/base'
require 'blackhawk_api/client/resources/account_processing'
require 'blackhawk_api/client/resources/account_transaction'
require 'blackhawk_api/client/resources/egift_management'
require 'blackhawk_api/client/resources/egift_processing'
require 'blackhawk_api/client/resources/product'
require 'blackhawk_api/client/resources/product_line'
require 'blackhawk_api/client/resources/product_catalog'

# Include Repositories
require 'blackhawk_api/client/client'
require 'blackhawk_api/client/data/account_repository'
require 'blackhawk_api/client/data/account_transaction_repository'
require 'blackhawk_api/client/data/gift_repository'
require 'blackhawk_api/client/data/product_repository'
require 'blackhawk_api/client/data/product_catalog_repository'
require 'blackhawk_api/client/data/productline_repository'

# Include Application Services
require 'blackhawk_api/client/services/service_base'
require 'blackhawk_api/client/services/account_service'
require 'blackhawk_api/client/services/account_transaction_service'
require 'blackhawk_api/client/services/giftcard_service'
require 'blackhawk_api/client/services/product_catalog_service'
require 'blackhawk_api/client/services/product_line_service'
require 'blackhawk_api/client/services/product_service'