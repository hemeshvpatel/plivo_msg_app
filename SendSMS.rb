require 'rubygems'
require 'plivo'

include Plivo

auth_id = ENV['AUTH_ID']
auth_token = ENV['AUTH_TOKEN']
subaccount_auth_id = ENV['SUBACCOUNT_AUTH_ID']

client = RestClient.new(auth_id, auth_token)
message_created = client.messages.create(
  '+15123573067',
  %w[+18326409882],
  'Hello, iPhone, thanks for getting this message!'
)