require "plivo"
require "sinatra"

include Plivo
include Plivo::XML

auth_id = ENV['AUTH_ID']
auth_token = ENV['AUTH_TOKEN']
subaccount_auth_id = ENV['SUBACCOUNT_AUTH_ID']

get "/reply_to_sms/" do
  from_number = params[:From]
  to_number = params[:To]
  text = params[:Text]
  puts "Message received - From: #{from_number}, To: #{to_number}, Text: #{text}"

  # send the details to generate an XML
  response = Response.new
  params = {
    src: to_number,
    dst: from_number,
  }
  message_body = "Thank you, we have received your request"
  response.addMessage(message_body, params)
  xml = PlivoXML.new(response)

  content_type "application/xml"
  return xml.to_s()
end