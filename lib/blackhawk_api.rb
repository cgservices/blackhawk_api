require 'httpi'
require 'yaml'
require 'json'
require 'openssl'
require 'base64'
require 'uri'

# Include error values
require 'blackhawk_api/client/errors/api_error'
require 'blackhawk_api/client/errors/connection_error'
require 'blackhawk_api/client/errors/api_error_handler'

# Include value objects
require 'blackhawk_api/client/values/enumerations'
require 'blackhawk_api/client/values/blackhawk_identity'
require 'blackhawk_api/client/values/blackhawk_identity_array'

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
require 'blackhawk_api/client/validators/gift_validators'

# Include response objects
require 'blackhawk_api/client/responses/base_response'
require 'blackhawk_api/client/responses/account_responses'
require 'blackhawk_api/client/responses/gift_responses'
require 'blackhawk_api/client/responses/product_responses'

# Include REST Resources
require 'blackhawk_api/client/rest_resource'
require 'blackhawk_api/client/resources/account_processing_information'
require 'blackhawk_api/client/resources/account_transaction'
require 'blackhawk_api/client/resources/egift_management'
require 'blackhawk_api/client/resources/egift_processing'
require 'blackhawk_api/client/resources/product'
require 'blackhawk_api/client/resources/product_line'
require 'blackhawk_api/client/resources/product_catalog'
require 'blackhawk_api/client/http_client'

# Include Application Facade
require 'blackhawk_api/client/blackhawk_client'
