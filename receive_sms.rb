require "sinatra"

auth_id = ENV['AUTH_ID']
auth_token = ENV['AUTH_TOKEN']
subaccount_auth_id = ENV['SUBACCOUNT_AUTH_ID']

post '/receive_sms/' do
  from_number = params[:From]
  to_number = params[:To]
  text = params[:Text]
  puts "___----____----Message received - From: #{from_number}, To: #{to_number}, Text: #{text}"
end