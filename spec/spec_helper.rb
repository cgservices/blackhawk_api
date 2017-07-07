$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'httpi'
require 'pry'\

HTTPI.log = false

require 'blackhawk_api'
require 'httplog'

HttpLog.options[:logger]        = Logger.new($stdout)
HttpLog.options[:severity]      = Logger::Severity::INFO
HttpLog.options[:log_connect]   = false
HttpLog.options[:log_request]   = true
HttpLog.options[:log_headers]   = true
HttpLog.options[:log_data]      = true
HttpLog.options[:log_status]    = true
HttpLog.options[:log_response]  = true
HttpLog.options[:log_benchmark] = false
