require_relative 'config/environment'
require 'rubygems'
require 'plivo'
require 'dotenv'

Dotenv.load

include Plivo

class App < Sinatra::Base

	auth_id = ENV['AUTH_ID']
	auth_token = ENV['AUTH_TOKEN']
	subaccount_auth_id = ENV['SUBACCOUNT_AUTH_ID']

	get '/' do
		erb :index
	end

	post '/receive_sms/' do
		from_number = params[:From]
		@from = from_number

		to_number = params[:To]
		@to = to_number

		text = params[:Text]
		@text = text

		puts ">>>>>>>>>>>>>> Message received - From: #{from_number}, To: #{to_number}, Text: #{text} <<<<<<<<<<<<<<"
	end

	get '/resources' do 
		client = RestClient.new(auth_id,auth_token)
		client.resources.list; # List all resources, max 20 at a time

		client.resources.each do |resource|
			puts resource.id
		  end
	end 

	get "/message_history" do

		api = RestClient.new(auth_id,auth_token)
		messages = api.messages.list(
		limit: 5,
		offset: 0,
		message_direction: "inbound",
		message_type: "sms",
		message_state: "delivered",
		#from_number: "18326409882"
		#subaccount: subaccount_auth_id,
		)

		messages.each do |record|
			puts record
		end

		@all_messages = messages

		erb :message_history

	end

	post '/message' do
		#"From: #{params[:from]}, To: #{params[:to]}, Message: #{params[:message]}"

		to = []
		to.push(params[:to])

		client = RestClient.new(auth_id, auth_token)
		client.messages.create(
		"#{params[:from]}",
		to,
		"#{params[:message]}"
		)

		redirect '/message_history'
	end

end